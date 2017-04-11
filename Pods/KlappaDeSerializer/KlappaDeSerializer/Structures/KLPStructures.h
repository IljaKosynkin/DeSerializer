//
//  KLPStructures.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#ifndef KLPStructures_h
#define KLPStructures_h
#include <stdlib.h>

#define Value(name, key_, field_type_, decoded_type, req) struct Value* name = (struct Value*) malloc(sizeof(struct Value)); \
                                                             name->key = key_; \
                                                             name->mapped_key = key_; \
                                                             name->field_type = field_type_; \
                                                             name->value_type = decoded_type; \
                                                             name->required = req; \
                                                             name->reference = NULL;

#define Node(name, let) struct Node* name = (struct Node*) malloc(sizeof(struct Node)); \
                                        name->letter = let; \
                                        name->value = NULL; \
                                        name->descendants = NULL;

#define List(name) struct List* name = (struct List*) malloc(sizeof(struct List)); \
                   name->nodes = NULL; \
                   name->nodes_count = 0; \
                   name->middle_point = 0;

#define StateMachineNode(name) struct StateMachineNode* name = (struct StateMachineNode*) malloc(sizeof(struct StateMachineNode)); \
                               name->descendants = NULL; \
                               name->descendants_count = 0; \
                               name->excluded_symbols_for_any_link = NULL; \
                               name->emitter = NULL;

#define StateMachine(name) struct StateMachine* name = (struct StateMachine*) malloc(sizeof(struct StateMachine)); \
                           name->current_nodes = NULL; \
                           name->nodes_count = 0;

extern const short NORMAL_FIELD_TYPE;
extern const short OBJECT_FIELD_TYPE;
extern const short ARRAY_FIELD_TYPE;

extern const char* DECODED_TYPE_STRING;
extern const char* DECODED_TYPE_INT;
extern const char* DECODED_TYPE_FLOAT;

struct Node;
struct List;

struct Value {
    char* key;
    char* mapped_key;
    
    short field_type;
    char* value_type;
    
    short required;
    
    void* reference;
};

struct Node {
    char letter;
    struct Value* value;
    struct List* descendants;
};

struct List {
    struct Node** nodes;
    unsigned long long nodes_count;
    unsigned long long middle_point;
};

struct StateMachineNode {
    struct StateMachineNode** descendants;
    unsigned long long descendants_count;
    
    char transition_char;
    
    char* excluded_symbols_for_any_link;
    
    void (*emitter)(const char*);
};

struct StateMachine {
    struct StateMachineNode** current_nodes;
    unsigned long long nodes_count;
    
    struct StateMachineNode* final_node;
    struct StateMachineNode* start_node;
};

#endif /* KLPStructures_h */
