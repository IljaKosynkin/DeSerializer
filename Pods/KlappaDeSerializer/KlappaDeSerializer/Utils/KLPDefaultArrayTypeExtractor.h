//
//  KLPArrayTypeExtractor.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 2/5/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPDeserializable.h"
#import "KLPArrayTypeExtractor.h"

@interface KLPDefaultArrayTypeExtractor : NSObject<KLPArrayTypeExtractor>
- (Class) getType:(Class<KLPDeserializable>) forClass forField:(NSString*) fieldName;
@end
