//
//  NSURL+BPKit.m
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import "NSURL+BPKit.h"
#import "NSDictionary+BPKit.h"

@implementation NSURL (NSURL_BPKit)

+ (NSURL *)bp_urlWithString:(NSString *)urlString queryComponents:(NSDictionary *)queryComponents {
    return [NSURL URLWithString:[urlString stringByAppendingFormat:@"?%@", [queryComponents bp_queryStringForEntries]]];
}

@end
