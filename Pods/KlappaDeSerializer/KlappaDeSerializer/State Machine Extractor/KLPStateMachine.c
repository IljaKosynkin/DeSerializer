//
//  KLPStateMachine.c
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/29/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#include "KLPStateMachine.h"
#include <string.h>
#include <stdio.h>

static const char* start = NULL;
static const char* end = NULL;
static const char* type = NULL;

void emit_start(const char* position) {
    start = position;
}

void emit_end(const char* position) {
    end = position;
}

void emit_type(const char* t) {
    type = t;
}

void fill_machine(struct StateMachine* machine) {
    StateMachineNode(first)
    first->transition_char = 'T';
    
    machine->start_node->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    machine->start_node->descendants[0] = first;
    machine->start_node->descendants_count = 1;
    
    StateMachineNode(second)
    second->excluded_symbols_for_any_link = "@";
    second->transition_char = '.';
    second->emitter = emit_type;
    
    StateMachineNode(third)
    third->transition_char = '@';
    
    first->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*) * 2);
    first->descendants[0] = second;
    first->descendants[1] = third;
    first->descendants_count = 2;
    
    StateMachineNode(fourth)
    fourth->transition_char = '"';
    fourth->emitter = emit_start;
    
    third->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    third->descendants[0] = fourth;
    third->descendants_count = 1;
    
    StateMachineNode(fifth)
    fifth->transition_char = '.';
    fifth->excluded_symbols_for_any_link = "\"";
    
    fourth->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    fourth->descendants[0] = fifth;
    fourth->descendants_count = 1;
    
    StateMachineNode(sixth)
    sixth->transition_char = '"';
    sixth->emitter = emit_end;
    
    fifth->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    fifth->descendants[0] = sixth;
    fifth->descendants_count = 1;
    
    sixth->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    sixth->descendants[0] = machine->final_node;
    sixth->descendants_count = 1;
    
    second->descendants = (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    second->descendants[0] = machine->final_node;
    second->descendants_count = 1;
    
    machine->final_node->transition_char = '.';
}

struct StateMachine* create_machine_for_type_extraction() {
    StateMachine(state_machine)
    
    StateMachineNode(initial_node)
    StateMachineNode(final_node)
    
    state_machine->start_node = initial_node;
    state_machine->current_nodes =  (struct StateMachineNode**) malloc(sizeof(struct StateMachineNode*));
    state_machine->current_nodes[0] = state_machine->start_node;
    state_machine->nodes_count = 1;
    state_machine->final_node = final_node;
    
    fill_machine(state_machine);
    
    return state_machine;
}

short pass_symbol(struct StateMachine* machine, const char* type) {
    char transition;
    for (int i = 0; i < machine->nodes_count; i++) {
        
        struct StateMachineNode* node = machine->current_nodes[i];
        for (int j = 0; j < node->descendants_count; j++) {
            struct StateMachineNode* descendant = node->descendants[j];
            transition = descendant->transition_char;
            
            if (transition == *type) {
                machine->current_nodes[i] = descendant;
                if (descendant->emitter != NULL) {
                    descendant->emitter(type);
                }
            } else if (transition == '.') {
                if (descendant->excluded_symbols_for_any_link != NULL) {
                    if (descendant->excluded_symbols_for_any_link[0] != *type) {
                        machine->current_nodes[i] = descendant;
                        if (descendant->emitter != NULL) {
                            descendant->emitter(type);
                        }
                    }
                } else {
                    machine->current_nodes[i] = descendant;
                    if (descendant->emitter != NULL) {
                        descendant->emitter(type);
                    }
                }
            }
        }
    }
    
    return machine->current_nodes[0] != machine->final_node;
}

unsigned short get_number_count(unsigned long diff) {
    if (diff < 10) { return 1; }
    if (diff < 100) { return 2; }
    if (diff < 1000) { return 3; }
    if (diff < 10000) { return 4; }
    if (diff < 100000) { return 5; }
    if (diff < 1000000) { return 6; }
    if (diff < 10000000) { return 7; }
    if (diff < 100000000) { return 8; }
    return 0;
}

const char* post_process() {
    char* processed;
    unsigned long long length = end - start;
    
    if (start[1] == '_' && start[2] =='T' && start[3] == 't') {
        const char* name_start = NULL;
        const char* project_start;
        const char* project_end = NULL;
        
        unsigned long offset = 0;
        
        for (const char* it = end; it != start; it--) {
            if (*it >= '0' && *it <= '9') {
                name_start = it + 1;
                project_end = it - get_number_count(end - name_start);
                break;
            }
        }
        
        for (const char* it = start + 5; it != end; it++) {
            if (*it >= '0' && *it <= '9') {
                offset = offset * 10 + (*it - '0');
                if (it + offset == project_end) {
                    project_start = it + 1;
                    break;
                }
            }
        }
        
        unsigned long string_length = offset + (end - name_start) + 2;
        processed = (char*) malloc(sizeof(char) * string_length);
        memcpy(processed, project_start, sizeof(char) * offset);
        processed[offset] = '.';
        memcpy(processed + offset + 1, name_start, sizeof(char) * (end - name_start));
        processed[string_length - 1] = '\0';
    } else {
        processed = (char*) malloc(sizeof(char) * (length));
        length--;
        memcpy(processed, start + 1, sizeof(char) * length);
        processed[length] = '\0';
    }
    
    return processed;
}

const char* extract_type(struct StateMachine* machine, const char* t) {
    type = NULL;
    start = NULL;
    end = NULL;
    
    
    machine->current_nodes[0] = machine->start_node;
    machine->nodes_count = 1;
    
    for (int i = 0; pass_symbol(machine, t + i); i++);
    
    char* copied = "";
    if (type != NULL) {
        copied = (char*)malloc(sizeof(char) * 2);
        copied[0] = *type;
        copied[1] = '\0';
    } else if (start != NULL && end != NULL) {
        copied = post_process();
    }
    
    return copied;
}
