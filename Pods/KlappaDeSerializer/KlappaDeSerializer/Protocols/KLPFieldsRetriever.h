//
//  KLPValuesRetriever.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KLPFieldsRetriever <NSObject>
- (NSDictionary*) getFields:(Class) forClass;
@end
