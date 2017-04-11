//
//  KLPValueConverter.h
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 1/28/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KLPValueConverter <NSObject>
- (id) convert:(id) value;
@end
