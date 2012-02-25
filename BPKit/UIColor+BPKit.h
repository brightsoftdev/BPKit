//
//  UIColor+BPKit.h
//  LampPost
//
//  Created by Brian Partridge on 2/23/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BPKit)

+ (UIColor *)bp_colorWithHex:(NSString *)hex;
+ (UIColor *)bp_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

@end
