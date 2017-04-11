//
//  KLPObjectSchema.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "KLPMultidimensionalTree.h"
#include "KLPNamingStrategy.h"


@interface KLPObjectSchema : NSObject
@property NSMutableArray* keys;
@property NSString* strategyID;

- (void) addProperty:(NSString*) name value:(struct Value*) value;
- (struct Node*) getNodeForName:(NSString*) name;
- (void) reload:(id<KLPNamingStrategy>) strategy;
@end
