//
//  NSDictionary+BPKit.m
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import "NSDictionary+BPKit.h"

@implementation NSDictionary (BPKit)

- (NSString  *)bp_stringForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null] || 
        ![object isKindOfClass:[NSString class]]) {
		return nil;
	}
	return object;
}

- (NSNumber *)bp_numberForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null] || 
        ![object isKindOfClass:[NSNumber class]]) {
		return nil;
	}
	return object;
}

- (NSDictionary *)bp_dictionaryForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null] || 
        ![object isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	return object;
}

- (NSArray *)bp_arrayForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null] || 
        ![object isKindOfClass:[NSArray class]]) {
		return nil;
	}
	return object;
}

- (NSString *)bp_queryStringForEntries {
    NSMutableArray *components = [NSMutableArray array];
    id key;
    while ((key = [self.keyEnumerator nextObject])) {
        id value = [self objectForKey:key];
        NSString *component = [NSString stringWithFormat: @"%@=%@", 
                               [key bp_urlEncodedString], 
                               [value bp_urlEncodedString]];
        [components addObject:component];
    }
    return [components componentsJoinedByString: @"&"];
}

@end
