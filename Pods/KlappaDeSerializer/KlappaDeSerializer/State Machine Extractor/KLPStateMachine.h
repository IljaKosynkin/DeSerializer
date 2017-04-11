//
//  KLPStateMachine.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/29/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#ifndef KLPStateMachine_h
#define KLPStateMachine_h

#include <stdio.h>
#include "KLPStructures.h"

struct StateMachine* create_machine_for_type_extraction();

const char* extract_type(struct StateMachine* machine, const char* type);

#endif /* KLPStateMachine_h */
