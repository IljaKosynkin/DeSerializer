//
//  KLPDeserializerFactory.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/25/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPDeserializable.h"
#import "KLPDeserializerProtocol.h"
#import "KLPSchemaManager.h"

@interface KLPDeserializer : NSObject
+ (id) deserializeWithString:(Class<KLPDeserializable>) deserializationClass jsonString:(NSString*) json;
+ (NSArray*) deserializeWithArray:(Class<KLPDeserializable>) deserializationClass array:(NSArray*) json;

+ (NSArray*) deserializeWithArrayOfPrimitives:(NSString*) string;

+ (id) deserializeWithDictionary:(Class<KLPDeserializable>) deserializationClass jsonDictionary:(NSDictionary*) json;
+ (id) deserializeWithDictionaryForField:(Class<KLPDeserializable>) deserializationClass jsonDictionary:(NSDictionary*) json field:(NSString*) fieldName context:(Class*) context;

+ (void) setDefaultDeserializer:(id<KLPDeserializerProtocol>) defaultDeserializer;
+ (void) registerDeserializer:(id<KLPDeserializerProtocol>) deserializer name:(NSString*) fieldName context:(Class<KLPDeserializable>*) context;

+ (void) addValueConverter:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputClass:(Class) output;
+ (void) addValueConverterForCustomClass:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forCustomClass:(Class) type forOutputClass:(Class) output;

+ (void) setSchemaManager:(id<KLPSchemaManager>) schemaManager;
+ (void) setGlobalNamingStrategy:(id<KLPNamingStrategy>) namingStrategy;
@end
