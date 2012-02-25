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
    return ((aString == nil) || (aString.length == 0));
}

- (NSString *)bp_trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (int)bp_hexValue {
    int result = 0;
    
    // Remove any '#' prefix from the hex string.
    NSString *source = [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    sscanf([source cStringUsingEncoding:NSUTF8StringEncoding], "%x", &result);
    
    return result;
}

- (NSString *)bp_urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                          (__bridge CFStringRef)self, 
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ "), 
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];    
    
    if(!encodedString)
        encodedString = @"";    
    
    return encodedString;
}

- (NSString *)bp_urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, 
                                                                                          (__bridge CFStringRef)self, 
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)decodedCFString];    
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}


- (BOOL)bp_containsString:(NSString*)aString caseSensitive:(BOOL)caseSensitive {
    NSString *mainString = (caseSensitive) ? self : [self lowercaseString];
    NSString *searchString = (caseSensitive) ? aString : [aString lowercaseString];
    NSRange range = [mainString rangeOfString:searchString];
    return (range.location != NSNotFound);
}

@end
