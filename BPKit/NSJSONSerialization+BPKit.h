//
//  NSJSONSerialization+BPKit.h
//  LampPost
//
//  Created by Brian Partridge on 2/11/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (BPKit)

+ (NSArray *)bp_JSONArrayWithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error;
+ (NSArray *)bp_JSONDictionaryWithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error;

@end
