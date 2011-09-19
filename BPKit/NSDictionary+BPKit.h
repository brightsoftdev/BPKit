//
//  NSDictionary+BPKit.h
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (BPKit)

#pragma mark - Accessors

- (NSString *)bp_stringForKey:(id)key;

- (NSNumber *)bp_numberForKey:(id)key;

- (NSDictionary *)bp_dictionaryForKey:(id)key;

- (NSArray *)bp_arrayForKey:(id)key;

#pragma mark - URL Encoding
// Join the key-value pairs in this dictionary into a URL encoded string suitable for use in a url.
- (NSString *)bp_queryStringForEntries;

@end
