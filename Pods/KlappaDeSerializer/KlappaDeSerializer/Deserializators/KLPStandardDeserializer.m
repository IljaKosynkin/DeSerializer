//
//  KLPStandardDeserializer.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPStandardDeserializer.h"
#import "KLPDeserializer.h"
#import "KLPDefaultNamingStrategy.h"
#import "KLPDefaultFieldsRetriever.h"
#import "KLPDefaultArrayTypeExtractor.h"
#import "KLPDefaultSchemaManager.h"
#include "KLPCommonVariables.h"
#import <objc/runtime.h>

static NSString* separator = @"|\\o/|";

@implementation KLPStandardDeserializer {
    struct Node* converters;
}

- (id) init {
    self = [super init];
    Node(root, '\0')
    converters = root;
    _retriever = [[KLPDefaultFieldsRetriever alloc] init];
    _extractor = [[KLPDefaultArrayTypeExtractor alloc] init];
    
    
    if (defaultManager == nil || defaultStrategy == nil) {
        [KLPDeserializer performSelector: @selector(postInit)];
    }
    
    return self;
}

- (NSObject<KLPDeserializable>*) deserialize:(Class<KLPDeserializable>) classToDeserialize json:(NSDictionary*) jsonToDeserialize {
    NSObject<KLPDeserializable>* object = [[classToDeserialize alloc] init];
    KLPObjectSchema* schema = [defaultManager retrieveSchema: classToDeserialize];
    
    for (NSString* key in schema.keys) {
        struct Node* node = [schema getNodeForName:key];
        if (node == NULL) {
            continue;
        }
        
        NSString* translatedKey = [NSString stringWithUTF8String:node->value->mapped_key];
        NSString* type = [NSString stringWithUTF8String:node->value->value_type];
        
        id value = jsonToDeserialize[translatedKey];
        if (value == nil) {
            continue;
        }
        
        if (node->value->field_type == OBJECT_FIELD_TYPE) {
            Class<KLPDeserializable> expectedClass = NSClassFromString(type);
            if (expectedClass == nil) {
                [NSException raise:@"Class for field not found." format:@"Couldn't find class mapping for field %@", translatedKey];
            }
            
            [object setValue:[KLPDeserializer deserializeWithDictionaryForField:expectedClass jsonDictionary:value field:key context: &classToDeserialize] forKey:key];
        } else if (node->value->field_type == ARRAY_FIELD_TYPE) {
            Class<KLPDeserializable> expectedClass = NSClassFromString(type);
            if (expectedClass == nil) {
                [object setValue:value forKey:key];
            } else {
                [object setValue:[KLPDeserializer deserializeWithArray:expectedClass array:value] forKey:key];
            }
        } else {
            if (converters->descendants != NULL) {
                NSString* inputType = NSStringFromClass([value class]);
                NSString* fullKey = [[key stringByAppendingString:inputType] stringByAppendingString:type];
                struct Node* node = find_node(converters, [fullKey cStringUsingEncoding:NSUTF8StringEncoding]);
                if (node != NULL) {
                    id<KLPValueConverter> converter = (__bridge id<KLPValueConverter>)(node->value->reference);
                    value = [converter convert:value];
                }
            }
            
            [object setValue:value forKey:key];
        }
    }
    
    for (NSString* name in [classToDeserialize getRequiredFields]) {
        if ([object valueForKey:name] == nil) {
            return nil;
        }
    }
    
    return object;
}

- (NSArray*) getValueOfType:(Type) type {
    switch (type) {
        case Integer:
            return @[@"__NSCFNumber"];
        case Double:
            return @[@"NSDecimalNumber"];
        case String:
            return @[@"__NSCFString", @"NSTaggedPointerString"];
        case Null:
            return @[@"NSNull"];
    }
}

- (void) addValueConverterForPrimitive:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputType:(Type) output {
    NSArray* inputTypes = [self getValueOfType:type];
    NSArray* outputTypes = [self getValueOfType:output];
    
    for (NSString* input in inputTypes) {
        for (NSString* output in outputTypes) {
            NSString* fullKey = [[fieldName stringByAppendingString:input] stringByAppendingString:output];
            
            const char* key = transfer([fullKey cStringUsingEncoding:NSUTF8StringEncoding]);
            Value(converterValue, key, OBJECT_FIELD_TYPE, "", 1)
            converterValue->reference = CFBridgingRetain(converter);
            add_field(converters, converterValue);
        }
    }
}

- (void) addValueConverter:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputClass:(Class) output {
    NSArray* types = [self getValueOfType:type];
    NSString* outputType = NSStringFromClass(output);
    for (NSString* type in types) {
        NSString* fullKey = [[fieldName stringByAppendingString:type] stringByAppendingString:outputType];
        const char* key = transfer([fullKey cStringUsingEncoding:NSUTF8StringEncoding]);
        Value(converterValue, key, OBJECT_FIELD_TYPE, "", 1)
        converterValue->reference = CFBridgingRetain(converter);
        add_field(converters, converterValue);
    }
}

- (void) addValueConverterForCustomClass:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forCustomClass:(Class) type forOutputClass:(Class) output {
    NSString* inputType = NSStringFromClass(type);
    NSString* outputType = NSStringFromClass(output);
    NSString* fullKey = [[fieldName stringByAppendingString:inputType] stringByAppendingString:outputType];
    const char* key = transfer([fullKey cStringUsingEncoding:NSUTF8StringEncoding]);
    Value(converterValue, key, OBJECT_FIELD_TYPE, "", 1)
    converterValue->reference = CFBridgingRetain(converter);
    add_field(converters, converterValue);
}

@end
