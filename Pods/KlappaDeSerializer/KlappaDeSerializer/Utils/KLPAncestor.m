//
//  KLPAncestor.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 4/3/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPAncestor.h"
#import "KLPCommonVariables.h"

@implementation KLPAncestor

+ (id<KLPNamingStrategy>) getNamingStrategy {
    return defaultStrategy;
}

+ (NSDictionary*) getFieldsToClassMap {
    return nil;
}

+ (NSDictionary*) getCustomFieldsMapping {
    return nil;
}

+ (NSArray*) getRequiredFields {
    return nil;
}

@end
