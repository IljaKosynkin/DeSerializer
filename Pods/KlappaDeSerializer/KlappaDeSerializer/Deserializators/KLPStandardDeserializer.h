//
//  KLPStandardDeserializer.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPDeserializerProtocol.h"
#import "KLPDeserializable.h"
#import "KLPValueConverter.h"
#import "KLPConvertedTypes.h"
#import "KLPFieldsRetriever.h"
#import "KLPArrayTypeExtractor.h"
#import "KLPSchemaManager.h"

@interface KLPStandardDeserializer : NSObject<KLPDeserializerProtocol> {

}

@property id<KLPFieldsRetriever> retriever;
@property id<KLPArrayTypeExtractor> extractor;

- (NSObject<KLPDeserializable>*) deserialize:(Class<KLPDeserializable>) classToDeserialize json:(NSDictionary*) jsonToDeserialize;

- (void) addValueConverterForPrimitive:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputType:(Type) output;
- (void) addValueConverter:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputClass:(Class) output;
- (void) addValueConverterForCustomClass:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forCustomClass:(Class) type forOutputClass:(Class) output;
@end
