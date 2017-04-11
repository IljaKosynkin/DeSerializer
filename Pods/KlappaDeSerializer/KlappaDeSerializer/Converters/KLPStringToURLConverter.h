//
//  KLPStringToURLConverter.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/31/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPValueConverter.h"

@interface KLPStringToURLConverter : NSObject<KLPValueConverter>
- (id) convert:(id)value;
@end
