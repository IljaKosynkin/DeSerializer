//
//  KLPMultidimensionalTree.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#ifndef KLPMultidimensionalTree_h
#define KLPMultidimensionalTree_h

#include "KLPTreeLevelList.h"

void add_field(struct Node* root_node, struct Value* value);
struct Node* find_node(struct Node* root_node, const char* name);

void release_tree();

const char* transfer(const char* string);


#endif /* KLPMultidimensionalTree_h */
