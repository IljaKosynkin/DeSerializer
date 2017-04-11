//
//  KLPStringToNumberConverter.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 2/12/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPStringToNumberConverter.h"

static NSNumberFormatter* formatter;

@implementation KLPStringToNumberConverter

- (instancetype) init {
    self = [super init];
    formatter = [[NSNumberFormatter alloc] init];
    return self;
}

- (id) convert:(id) value {
    NSString* val = value;
    return [formatter numberFromString:val];
}
@end
