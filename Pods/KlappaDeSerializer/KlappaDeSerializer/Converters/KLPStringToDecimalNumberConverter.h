//
//  KLPStringToDecimalNumberConverter.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 2/12/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLPValueConverter.h"

@interface KLPStringToDecimalNumberConverter : NSObject<KLPValueConverter>
- (id) convert:(id) value;
@end
