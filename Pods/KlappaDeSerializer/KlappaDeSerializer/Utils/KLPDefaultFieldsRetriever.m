//
//  KLPFieldsRetriever.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPDefaultFieldsRetriever.h"
#include "KLPStateMachine.h"
#import <objc/runtime.h>

static struct StateMachine* machine = NULL;

@implementation KLPDefaultFieldsRetriever

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (machine == NULL) {
            machine = create_machine_for_type_extraction();
        }
    }
    return self;
}

- (void) getFieldsOfClass:(Class)class fields:(NSMutableDictionary**) fieldsMap {
    unsigned int count;
    
    objc_property_t* props = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        
        const char* name = property_getName(property);
        const char* type = property_getAttributes(property);
        
        const char* extracted = extract_type(machine, type);
        
        NSString* stringName = [NSString stringWithUTF8String:name];
        NSString* stringType = [[NSString alloc] initWithBytesNoCopy:(void*) extracted length:strlen(extracted) encoding:NSUTF8StringEncoding freeWhenDone:YES];
        (*fieldsMap)[stringName] = stringType;
    }
    
    free(props);
}

- (NSDictionary*) getFields:(Class) forClass {
    NSMutableDictionary* fields = [[NSMutableDictionary alloc] init];
    
    Class currentClass = forClass;
    while (YES) {
        [self getFieldsOfClass:currentClass fields:&fields];
        currentClass = [currentClass superclass];
        if (currentClass == [NSObject class]) {
            break;
        }
    }
    
    return fields;
}

@end
