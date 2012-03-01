//
//  NSSet+BPKit.h
//  BPKit
//
//  Created by Brian Partridge on 2/29/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (BPKit)

- (NSSet *)bp_objectsNotInSet:(NSSet *)set;

@end
