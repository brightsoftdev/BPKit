//
//  NSJSONSerialization+BPKit.m
//  LampPost
//
//  Created by Brian Partridge on 2/11/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "NSJSONSerialization+BPKit.h"

@interface NSJSONSerialization (BPKit_Private)

+ (id)bp_JSONObjectOfClass:(Class)class WithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error;

@end

@implementation NSJSONSerialization (BPKit)

+ (id)bp_JSONObjectOfClass:(Class)class WithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error {
    id result = nil;
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:options error:error];
    if (*error == nil) {
        if ([object isKindOfClass:class]) {
            result = object;
        } else {
            *error = [NSError errorWithDomain:BPKitErrorDomain code:BPKitErrorUnexpectedReturnType userInfo:nil];
        }
    }
    
    return result;
}

+ (NSArray *)bp_JSONArrayWithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error {
    return [NSJSONSerialization bp_JSONObjectOfClass:[NSArray class] WithData:data options:options error:error];
}

+ (NSArray *)bp_JSONDictionaryWithData:(NSData *)data options:(NSJSONReadingOptions)options error:(NSError **)error {
    return [NSJSONSerialization bp_JSONObjectOfClass:[NSDictionary class] WithData:data options:options error:error];
}

@end
