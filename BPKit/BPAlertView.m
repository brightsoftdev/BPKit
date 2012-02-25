//
//  BPAlertView.m
//  BPKit
//
//  Created by Brian Partridge on 2/25/12.
//  Copyright 2012 Brian Partridge. All rights reserved.
//

#import "BPAlertView.h"

@interface BPAlertView ()

@property (nonatomic, copy) BPAlertBlock cancelBlock;
@property (nonatomic, copy) BPAlertBlock otherBlock;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *otherButtonTitle;

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
        cancelTitle:(NSString *)cancelTitle 
        cancelBlock:(BPAlertBlock)cancelBlock
         otherTitle:(NSString *)otherTitle
         otherBlock:(BPAlertBlock)otherBlock;

@end

@implementation BPAlertView

@synthesize cancelBlock;
@synthesize otherBlock;
@synthesize cancelButtonTitle;
@synthesize otherButtonTitle;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          buttonTitle:(NSString *)buttonTitle {
    [self showWithTitle:title message:message
            cancelTitle:buttonTitle cancelBlock:nil
             otherTitle:nil otherBlock:nil];
}

+ (void)showWithTitle:(NSString *)title 
              message:(NSString *)message 
          cancelTitle:(NSString *)cancelTitle 
          cancelBlock:(BPAlertBlock)cancelBlk
           otherTitle:(NSString *)otherTitle
           otherBlock:(BPAlertBlock)otherBlk {
    [[[self alloc] initWithTitle:title message:message
                     cancelTitle:cancelTitle cancelBlock:cancelBlk
                      otherTitle:otherTitle otherBlock:otherBlk] show];                           
}

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
        cancelTitle:(NSString *)cancelTitle 
        cancelBlock:(BPAlertBlock)cancelBlk
         otherTitle:(NSString *)otherTitle
         otherBlock:(BPAlertBlock)otherBlk {
		 
    if ((self = [super initWithTitle:title 
                             message:message
                            delegate:self
                   cancelButtonTitle:cancelTitle 
                   otherButtonTitles:otherTitle, nil])) {
				   
        if (cancelBlk == nil && 
            otherBlk == nil) {
            self.delegate = nil;
        }
        
        self.cancelButtonTitle = cancelTitle;
        self.otherButtonTitle = otherTitle;
        self.cancelBlock = cancelBlk;
        self.otherBlock = otherBlk;
    }
    return self;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.cancelButtonIndex) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    } else if (buttonIndex == self.firstOtherButtonIndex) {
        if (self.otherBlock != nil) {
            self.otherBlock();
        }
    }
}

@end