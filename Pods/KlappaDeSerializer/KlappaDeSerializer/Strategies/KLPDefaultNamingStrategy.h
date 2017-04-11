//
//  KLPDefaultNamingStrategy.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/24/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPNamingStrategy.h"

@interface KLPDefaultNamingStrategy : NSObject<KLPNamingStrategy>
- (NSString*) convertName:(NSString*) originalName;
@end
