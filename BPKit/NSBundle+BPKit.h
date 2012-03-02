//
//  NSBundle+BPKit.h
//  BPKit
//
//  Created by Brian Partridge on 3/2/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (BPKit)

- (NSString *)bp_name;
- (NSString *)bp_version;
- (id)bp_infoObjectForKey:(id)key;

@end
