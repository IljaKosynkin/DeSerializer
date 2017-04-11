//
//  KLPMultidimensionalTree.c
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#include "KLPMultidimensionalTree.h"

const short NORMAL_FIELD_TYPE = 0;
const short OBJECT_FIELD_TYPE = 1;
const short ARRAY_FIELD_TYPE = 2;

const char* DECODED_TYPE_STRING = "s";
const char* DECODED_TYPE_INT = "i";
const char* DECODED_TYPE_FLOAT = "f";

void add_field_r(struct Node* root_node, const char* name, unsigned long long current_depth, struct Value* value) {
    if (current_depth == 0) {
        root_node->value = value;
        return;
    }
    
    struct Node* next_node = search_for_letter(root_node->descendants, name[0]);
    
    if (next_node == NULL) {
        Node(next, name[0])
        next_node = next;
        
        if (root_node->descendants == NULL) {
            List(next_list)
            root_node->descendants = next_list;
        }
        
        add_node(root_node->descendants, next_node);
    }
    
    add_field_r(next_node, name + 1, current_depth - 1, value);
}

void add_field(struct Node* root_node, struct Value* value) {
    unsigned long depth = strlen(value->key);
    add_field_r(root_node, value->key, depth, value);
}

struct Node* find_node(struct Node* root_node, const char* name) {
    if (root_node == NULL) {
        return NULL;
    }
    
    if (name[0] == 0) {
        return root_node;
    }
    
    struct Node* next_node = search_for_letter(root_node->descendants, name[0]);
    if (next_node == NULL) {
        return NULL;
    }
    
    return find_node(next_node, name + 1);
}

void release_tree_r(struct Node* current_node) {
    if (current_node->descendants != NULL) {
        for (int i = 0; i < current_node->descendants->nodes_count; i++) {
            release_tree_r(current_node->descendants->nodes[i]);
        }
    }
    
    free(current_node->descendants->nodes);
    free(current_node->descendants);
    free(current_node->value->mapped_key);
    free(current_node->value->key);
    free(current_node->value->reference);
    free(current_node->value->value_type);
    free(current_node->value);
    free(current_node);
}

void release_tree(struct Node* root) {
    release_tree_r(root);
}

const char* transfer(const char* string) {
    unsigned long length = strlen(string) + 1;
    char* str = (char*) malloc(length * sizeof(char));
    length--;
    memcpy(str, string, sizeof(char) * length);
    str[length] = '\0';
    return str;
}
