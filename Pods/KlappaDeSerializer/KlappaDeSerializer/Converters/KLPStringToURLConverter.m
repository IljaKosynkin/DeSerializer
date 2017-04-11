//
//  KLPStringToURLConverter.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/31/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPStringToURLConverter.h"

@implementation KLPStringToURLConverter
- (id) convert:(id)value {
    NSString* urlString = value;
    return [[NSURL alloc] initWithString: urlString];
}
@end
