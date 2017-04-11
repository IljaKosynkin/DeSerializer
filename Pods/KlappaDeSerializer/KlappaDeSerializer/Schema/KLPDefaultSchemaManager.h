//
//  KLPDefaultSchemaManager.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KLPArrayTypeExtractor.h"
#import "KLPFieldsRetriever.h"

#include "KLPSchemaManager.h"
#include "KLPMultidimensionalTree.h"

@interface KLPDefaultSchemaManager : NSObject<KLPSchemaManager>

@property id<KLPFieldsRetriever> fieldsRetriever;
@property id<KLPArrayTypeExtractor> arrayTypeExtractor;

- (KLPObjectSchema*) createSchema:(Class<KLPDeserializable>) forObject;
- (KLPObjectSchema*) retrieveSchema:(Class<KLPDeserializable>) forObject;

@end
