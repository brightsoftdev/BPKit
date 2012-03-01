//
//  NSSet+BPKit.m
//  BPKit
//
//  Created by Brian Partridge on 2/29/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "NSSet+BPKit.h"

@implementation NSSet (BPKit)

- (NSSet *)bp_objectsNotInSet:(NSSet *)set {
    NSMutableSet *mutableSelf = [self mutableCopy];
    [mutableSelf minusSet:set];
    return [mutableSelf copy];
}

@end
