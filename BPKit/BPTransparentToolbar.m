//
//  BPTransparentToolbar.m
//  BPKit
//
//  Created by Brian Partridge on 11/28/10.
//  Copyright 2010 Brian Partridge. All rights reserved.
//

#import "BPTransparentToolbar.h"

@interface BPTransparentToolbar ()

-(void)applyAppearance;

@end

@implementation BPTransparentToolbar

@synthesize transparent;

-(void)setTransparent:(BOOL)bTransparent {
    if (bTransparent == transparent) {
        return;
    }
    
    transparent = bTransparent;
    
    [self applyAppearance];
}

-(void)drawRect:(CGRect)rect {
    // Only draw when not transparent
    if (!transparent) {
        [super drawRect:rect];
    }
}

-(void)applyAppearance {
    if (transparent) {
        // Set the transparent background
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    else {
        // Set the default values
        self.backgroundColor = nil;
        self.opaque = YES;
    }
    [self setNeedsDisplay];
}

-(id)init {
	if ((self = [super init])) {
        transparent = YES;
		[self applyAppearance];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        transparent = YES;
		[self applyAppearance];
	}
	return self;
}

@end
