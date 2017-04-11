//
//  KLPDeserializerFactory.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/25/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPDeserializer.h"
#import "KLPStandardDeserializer.h"
#import "KLPDefaultSchemaManager.h"
#import "KLPDefaultNamingStrategy.h"
#include "KLPCommonVariables.h"
#import <UIKit/UIKit.h>

static id<KLPDeserializerProtocol> defaultDeserializer;
static NSMutableDictionary* fieldsDeserializers;

id<KLPSchemaManager> defaultManager;
id<KLPNamingStrategy> defaultStrategy;

@implementation KLPDeserializer

- (instancetype)init {
    [NSException raise:@"This object is not supposed to be created" format:@""];
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    [NSException raise:@"This object is not supposed to be created" format:@""];
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    [NSException raise:@"This object is not supposed to be created" format:@""];
    return nil;
}

+ (void) postInit {
    if (fieldsDeserializers == nil) fieldsDeserializers = [[NSMutableDictionary alloc] init];
    if (defaultStrategy == nil) defaultStrategy = [[KLPDefaultNamingStrategy alloc] init];
    if (defaultManager == nil) defaultManager = [[KLPDefaultSchemaManager alloc] init];
    if (defaultDeserializer == nil) defaultDeserializer = [[KLPStandardDeserializer alloc] init];
}

+ (id) deserializeWithString:(Class<KLPDeserializable>) deserializationClass jsonString:(NSString*) json {
    [KLPDeserializer postInit];
    
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    id object;
    if ([json hasPrefix:@"{"]) {
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        object = [KLPDeserializer deserializeWithDictionary:deserializationClass jsonDictionary:dictionary];
    } else {
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        object = [KLPDeserializer deserializeWithArray:deserializationClass array:array];
    }
    
    if (error != nil) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return object;
}

+ (NSArray*) deserializeWithArray:(Class<KLPDeserializable>) deserializationClass array:(NSArray*) json {
    [KLPDeserializer postInit];
    
    NSMutableArray* objects = [[NSMutableArray alloc] init];
    
    for (id object in json) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            [objects addObject:[KLPDeserializer deserializeWithDictionary:deserializationClass jsonDictionary:object]];
        } else if ([object isKindOfClass:[NSArray class]]) {
            [NSException raise:@"Nested arrays are not supported" format:@"[[], [], []] JSONs of such format are not suported"];
        } else {
            [objects addObject:object];
        }
    }
    
    return objects;
}

+ (NSArray*) deserializeWithArrayOfPrimitives:(NSString*) json {
    [KLPDeserializer postInit];
    
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

+ (id) deserializeWithDictionary:(Class<KLPDeserializable>) deserializationClass jsonDictionary:(NSDictionary*) json {
    [KLPDeserializer postInit];
    return [defaultDeserializer deserialize:deserializationClass json:json];
}

+ (id) deserializeWithDictionaryForField:(Class<KLPDeserializable>) deserializationClass jsonDictionary:(NSDictionary*) json field:(NSString*) fieldName context:(Class*) context {
    [KLPDeserializer postInit];
    
    NSString* key = [fieldName stringByAppendingString: (context != nil ? NSStringFromClass(*context) : @"")];
    id<KLPDeserializerProtocol> deserializer = fieldsDeserializers[key];
    if (deserializer == nil) {
        deserializer = fieldsDeserializers[fieldName];
    }
    return deserializer == nil ? [defaultDeserializer deserialize:deserializationClass json:json] : [deserializer deserialize:deserializationClass json:json];
}

+ (void) setDefaultDeserializer:(id<KLPDeserializerProtocol>) deserializer {
    [KLPDeserializer postInit];
    
    defaultDeserializer = deserializer;
}

+ (void) registerDeserializer:(id<KLPDeserializerProtocol>) deserializer name:(NSString*) fieldName context:(Class<KLPDeserializable>*) context {
    [KLPDeserializer postInit];
    
    NSString* type = context == nil ? @"" : NSStringFromClass(*context);
    NSString* key = [fieldName stringByAppendingString:type];
    fieldsDeserializers[key] = deserializer;
}

+ (void) addValueConverter:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputClass:(Class) output {
    [KLPDeserializer postInit];
    [defaultDeserializer addValueConverter:converter forField:fieldName forInputType:type forOutputClass:output];
}

+ (void) addValueConverterForCustomClass:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forCustomClass:(Class) type forOutputClass:(Class) output {
    [KLPDeserializer postInit];
    [defaultDeserializer addValueConverterForCustomClass:converter forField:fieldName forCustomClass:type forOutputClass:output];
}

+ (void) setSchemaManager:(id<KLPSchemaManager>) schemaManager {
    [KLPDeserializer postInit];
    defaultManager = schemaManager;
}

+ (void) setGlobalNamingStrategy:(id<KLPNamingStrategy>) namingStrategy {
    [KLPDeserializer postInit];
    defaultStrategy = namingStrategy;
}
@end
