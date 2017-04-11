//
//  KLPTreeLevelList.c
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#include "KLPTreeLevelList.h"

void add_node(struct List* list, struct Node* node) {
    list->nodes_count++;
    list->middle_point = list->nodes_count >> 1;
    
    struct Node** nodes = list->nodes;
    list->nodes = (struct Node**) malloc(sizeof(struct Node*) * list->nodes_count);
    
    if (list->nodes_count == 1) {
        list->nodes[0] = node;
        return;
    }
    
    short shifted = 0;
    for (int i = 0; i < list->nodes_count - 1; i++) {
        struct Node* current_node = nodes[i];
        if (shifted == 1 || current_node->letter < node->letter) {
            list->nodes[i + shifted] = current_node;
        } else {
            list->nodes[i] = node;
            shifted++;
            list->nodes[i + shifted] = current_node;
        }
    }
    
    if (shifted == 0) {
        list->nodes[list->nodes_count - 1] = node;
    }
    
    free((void*) nodes);
}

struct Node* search_for_letter(struct List* list, char letter) {
    if (list == NULL || list->nodes == NULL) { return NULL; }
    if (list->nodes[0]->letter > letter || list->nodes[list->nodes_count - 1]->letter < letter) { return NULL; }
    
    unsigned long long start_position = 0;
    unsigned long long end_position = 0;
    
    if (letter >= list->nodes[list->middle_point]->letter) {
        start_position = list->middle_point;
        end_position = list->nodes_count;
    } else {
        start_position = 0;
        end_position = list->middle_point;
    }
    
    for (; start_position < end_position; start_position++) {
        if (list->nodes[start_position]->letter == letter) {
            return list->nodes[start_position];
        }
    }
    
    return NULL;
}
