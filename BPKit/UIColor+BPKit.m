//
//  UIColor+BPKit.m
//  LampPost
//
//  Created by Brian Partridge on 2/23/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "UIColor+BPKit.h"

@implementation UIColor (BPKit)

+ (UIColor *)bp_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha {
    int hexValue = [hex bp_hexValue];
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0 
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)bp_colorWithHex:(NSString *)hex {
    return [UIColor bp_colorWithHex:hex alpha:1.0];
}

@end
