//
//  KLPDeserializer.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPNamingStrategy.h"
#import "KLPDeserializable.h"
#import "KLPValueConverter.h"
#import "KLPConvertedTypes.h"

@protocol KLPDeserializerProtocol <NSObject>
- (id<KLPDeserializable>) deserialize:(Class<KLPDeserializable>) classToDeserialize json:(NSDictionary*) jsonToDeserialize;
- (void) addValueConverter:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputClass:(Class) output;
- (void) addValueConverterForPrimitive:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forInputType:(Type) type forOutputType:(Type) output;
- (void) addValueConverterForCustomClass:(id<KLPValueConverter>) converter forField:(NSString*) fieldName forCustomClass:(Class) type forOutputClass:(Class) output;
@end
