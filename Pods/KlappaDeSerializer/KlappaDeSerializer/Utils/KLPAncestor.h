//
//  KLPAncestor.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 4/3/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPDeserializable.h"

@interface KLPAncestor : NSObject<KLPDeserializable>
+ (id<KLPNamingStrategy>) getNamingStrategy;

+ (NSDictionary*) getFieldsToClassMap;
+ (NSDictionary*) getCustomFieldsMapping;
+ (NSArray*) getRequiredFields;
@end
