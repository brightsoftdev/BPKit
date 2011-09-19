//
//  NSString+BPKit.m
//  BPKit
//
//  Created by Brian Partridge on 9/18/11.
//  Copyright 2011 Brian Partridge. All rights reserved.
//

#import "NSString+BPKit.h"


@implementation NSString (BPKit)

+ (BOOL)bp_isNilOrEmpty:(NSString *)aString {
    return ((aString == nil) || ([aString compare:[NSString string]] == NSOrderedSame));
}

- (NSString *)bp_trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)bp_stringByURLEncoding {
    NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                  (CFStringRef)self,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8);
    return [encodedString autorelease];
}

- (BOOL)bp_containsString:(NSString*)aString caseSensitive:(BOOL)caseSensitive {
    NSString *mainString = (caseSensitive) ? self : [self lowercaseString];
    NSString *searchString = (caseSensitive) ? aString : [aString lowercaseString];
    NSRange range = [mainString rangeOfString:searchString];
    return (range.location != NSNotFound);
}

@end
