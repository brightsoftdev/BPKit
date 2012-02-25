//
//  NSURL+BPKit.h
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURL (NSURL_BPKit)

#pragma mark - Helpers

+ (NSURL *)bp_urlWithString:(NSString *)urlString queryComponents:(NSDictionary *)queryComponents;

- (NSDictionary *)bp_queryComponents;

@end
