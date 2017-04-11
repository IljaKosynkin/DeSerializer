//
//  KLPSchemaCreator.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPObjectSchema.h"
#import "KLPDeserializable.h"
#import "KLPNamingStrategy.h"

@protocol KLPSchemaManager <NSObject>
- (KLPObjectSchema*) createSchema:(Class<KLPDeserializable>) forClass;
- (KLPObjectSchema*) retrieveSchema:(Class<KLPDeserializable>) forClass;
@end
