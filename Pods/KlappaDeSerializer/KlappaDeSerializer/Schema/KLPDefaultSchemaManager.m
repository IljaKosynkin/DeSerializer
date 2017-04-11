//
//  KLPDefaultSchemaManager.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPDefaultSchemaManager.h"
#import "KLPDefaultFieldsRetriever.h"
#import "KLPDefaultArrayTypeExtractor.h"
#import "KLPDefaultNamingStrategy.h"
#import "KLPCommonVariables.h"

@implementation KLPDefaultSchemaManager {
    struct Node* root_node;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        Node(root, '\0')
        self->root_node = root;
        
        self->_fieldsRetriever = [[KLPDefaultFieldsRetriever alloc] init];
        self->_arrayTypeExtractor = [[KLPDefaultArrayTypeExtractor alloc] init];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
- (KLPObjectSchema*) createSchema:(Class<KLPDeserializable>) forClass {
    KLPObjectSchema* schema = [[KLPObjectSchema alloc] init];
    
    NSDictionary* mappedFields = [forClass getCustomFieldsMapping];
    NSDictionary* fields = [_fieldsRetriever getFields:forClass];
    NSArray* required = [forClass getRequiredFields];
    
    id<KLPNamingStrategy> strategy = [forClass getNamingStrategy];
    strategy = strategy == nil ? defaultStrategy : strategy;
    
    schema.strategyID = NSStringFromClass([strategy class]);

    for (NSString* key in fields) {
        NSString* translatedKey = mappedFields[key];
        if (translatedKey == nil) {
            translatedKey = [strategy convertName:key];
        }
        
        NSString* type = fields[key];
        Class cls = NSClassFromString(type);
        
        BOOL req = [required containsObject:key];
        short required = req ? 1 : 0;
        
        const char* rawKey = transfer([key cStringUsingEncoding:NSUTF8StringEncoding]);
        const char* rawType = transfer([type cStringUsingEncoding:NSUTF8StringEncoding]);
        
        Value(value, rawKey, 0, rawType, required)
        value->mapped_key = transfer([translatedKey cStringUsingEncoding:NSUTF8StringEncoding]);
        
        if ([cls conformsToProtocol:@protocol(KLPDeserializable)]) {
            value->field_type = OBJECT_FIELD_TYPE;
            value->reference = CFBridgingRetain([self createSchema:cls]);
        } else if ([cls isSubclassOfClass:[NSArray class]]) {
            value->field_type = ARRAY_FIELD_TYPE;
            
            Class arrayClass = [_arrayTypeExtractor getType:forClass forField:key];
            value->value_type = arrayClass == nil ? "primitive" : transfer([NSStringFromClass(arrayClass) cStringUsingEncoding:NSUTF8StringEncoding]);
            if ([arrayClass conformsToProtocol:@protocol(KLPDeserializable)]) {
                value->reference = CFBridgingRetain([self createSchema:arrayClass]);
            }
        } else {
            value->field_type = NORMAL_FIELD_TYPE;
        }
        
        [schema addProperty:key value: value];
    }

    const char* schemaName = transfer([NSStringFromClass(forClass) cStringUsingEncoding:NSUTF8StringEncoding]);
    Value(schemaValue, schemaName, OBJECT_FIELD_TYPE, "", 1)
    schemaValue->reference = CFBridgingRetain(schema);
    add_field(root_node, schemaValue);
    
    return schema;
}
#pragma clang diagnostic pop

- (KLPObjectSchema*) retrieveSchema:(Class<KLPDeserializable>) forClass {
    const char* name = transfer([NSStringFromClass(forClass) cStringUsingEncoding:NSUTF8StringEncoding]);
    struct Node* foundNode = find_node(root_node, name);
    
    if (foundNode == NULL || foundNode->value == NULL) {
        return [self createSchema:forClass];
    } else {
        KLPObjectSchema* schema = (__bridge KLPObjectSchema*)foundNode->value->reference;
        
        id<KLPNamingStrategy> strategy = [forClass getNamingStrategy];
        strategy = strategy == nil ? defaultStrategy : strategy;
        
        if (![schema.strategyID isEqualToString:NSStringFromClass([strategy class])]) {
            [schema reload:strategy];
        }
        
        return schema;
    }
}
@end
