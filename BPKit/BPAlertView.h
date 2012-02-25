//
//  BPAlertView.h
//  BPKit
//
//  Created by Brian Partridge on 2/25/12.
//  Copyright 2012 Brian Partridge. All rights reserved.
//
// Originally from PRPAlertView from iOS Recipies by Matt Drance.
// Renamed, tweaked, and converted to ARC.

#import <UIKit/UIKit.h>

typedef void(^BPAlertBlock)(void);

@interface BPAlertView : UIAlertView {}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message 
          cancelTitle:(NSString *)cancelTitle 
          cancelBlock:(BPAlertBlock)cancelBlock
           otherTitle:(NSString *)otherTitle
           otherBlock:(BPAlertBlock)otherBlock;

@end
