//
//  KLPStringToDecimalNumberConverter.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 2/12/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPStringToDecimalNumberConverter.h"

@implementation KLPStringToDecimalNumberConverter
- (id) convert:(id) value {
    NSString* string = value;
    return [NSDecimalNumber decimalNumberWithString:string locale:nil];
}
@end
