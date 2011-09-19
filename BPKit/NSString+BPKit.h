//
//  NSString+BPKit.h
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPKit)

#pragma mark - Helpers

// Simple check for invalid strings.
+ (BOOL)bp_isNilOrEmpty:(NSString *)aString;

// Trim whitespace and newlines from the current instance.
- (NSString *)bp_trimmedString;

#pragma mark - URL Encoding

// Encodes characters not encoded by stringByAddingPercentEscapesUsingEncoding.
- (NSString *)bp_stringByURLEncoding;

#pragma mark - Searching

// Check whether the substring is contained within the current instance.
- (BOOL)bp_containsString:(NSString*)aString caseSensitive:(BOOL)caseSensitive;


@end
