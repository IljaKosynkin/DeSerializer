//
//  KLPFieldsRetriever.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/22/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPFieldsRetriever.h"

@interface KLPDefaultFieldsRetriever : NSObject<KLPFieldsRetriever>
- (NSDictionary*) getFields:(Class) forClass;
@end
