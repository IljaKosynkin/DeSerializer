//
//  KLPArrayTypeExtractor.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 2/5/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPDefaultArrayTypeExtractor.h"

@implementation KLPDefaultArrayTypeExtractor
- (Class) getType:(Class<KLPDeserializable>) forClass forField:(NSString*) fieldName {
    NSDictionary* dictionary = [forClass getFieldsToClassMap];
    return dictionary[fieldName];
}
@end
