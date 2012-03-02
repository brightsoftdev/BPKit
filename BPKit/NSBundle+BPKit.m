//
//  NSBundle+BPKit.m
//  BPKit
//
//  Created by Brian Partridge on 3/2/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "NSBundle+BPKit.h"

@implementation NSBundle (BPKit)

- (NSString *)bp_name {
    return [self bp_infoObjectForKey:(id)kCFBundleNameKey];
}

- (NSString *)bp_version {
    return [self bp_infoObjectForKey:(id)kCFBundleVersionKey];
}

- (id)bp_infoObjectForKey:(id)key {
    return [self.infoDictionary objectForKey:key];
}

@end
