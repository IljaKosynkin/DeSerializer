//
//  KLPTreeLevelList.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#ifndef KLPTreeLevelList_h
#define KLPTreeLevelList_h

#include <stdio.h>
#include <string.h>

#include "KLPStructures.h"

void add_node(struct List* list, struct Node* node);
struct Node* search_for_letter(struct List* list, char letter);

#endif /* KLPTreeLevelList_h */
