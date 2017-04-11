//
//  KLPDeserializable.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/25/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPNamingStrategy.h"

@protocol KLPDeserializable
+ (id) alloc;
- (id) init;

+ (id<KLPNamingStrategy>) getNamingStrategy;

+ (NSDictionary*) getFieldsToClassMap;
+ (NSDictionary*) getCustomFieldsMapping;
+ (NSArray*) getRequiredFields;
@end
