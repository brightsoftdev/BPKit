//
//  BPTransparentToolbar.h
//  BPKit
//
//  Created by Brian Partridge on 11/28/10.
//  Copyright 2010 Brian Partridge. All rights reserved.
//
//  Simple extension to UIToolbar to allow it to show buttons but no background.
//  Thanks to Andreas for the original implementation of the transparency functionality:
//  http://blog.blackwhale.at/2010/07/transparent-uitoolbar/

#import <UIKit/UIKit.h>

@interface BPTransparentToolbar : UIToolbar

@property (nonatomic, assign) BOOL transparent;

@end
