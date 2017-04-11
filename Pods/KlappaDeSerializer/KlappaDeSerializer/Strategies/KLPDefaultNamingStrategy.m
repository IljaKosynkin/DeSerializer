//
//  KLPDefaultNamingStrategy.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/24/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPDefaultNamingStrategy.h"

@implementation KLPDefaultNamingStrategy

- (NSString *)stringByReplacingCamelCaseWithSnakeCase:(NSString *)string {
    NSUInteger index = 1;
    NSMutableString *snakeCaseString = [NSMutableString stringWithString:string];
    NSUInteger length = snakeCaseString.length;
    NSCharacterSet *characterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    while (index < length) {
        if ([characterSet characterIsMember:[snakeCaseString characterAtIndex:index]]) {
            [snakeCaseString insertString:@"_" atIndex:index];
            index++;
        }
        index++;
    }
    
    return [snakeCaseString lowercaseString];
}

- (NSString*) convertName:(NSString*) originalName {
    return [self stringByReplacingCamelCaseWithSnakeCase:originalName];
}

@end
