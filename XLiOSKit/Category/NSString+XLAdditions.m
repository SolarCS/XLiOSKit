//
//  NSString+XLAdditions.m
//  XLiOSKit
//
// Copyright (c) 2013 Xmartlabs (http://xmartlabs.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSError+XLAdditions.h"


@implementation NSString (XLAdditions)


-(BOOL)isValidAsEmail:(NSError **)error
{
    NSString *regexForEmailAddress = @"[A-Z0-9a-z._%+'-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexForEmailAddress];
    BOOL success = [emailValidation evaluateWithObject:self];
    if (success == NO && error) {
        *error = [NSError errorWithDomain:XLErrorDomain code:XLErrorCodeInvalidEmail
                        userInfo:@{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(@"Invalid email address!", nil) }];
    }
    return success;
}

-(NSData *)UTF8Data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSURL *)fileURL
{
    return [NSURL fileURLWithPath:self isDirectory:NO];
}

-(NSURL *)URL
{
    return [NSURL URLWithString:self];
}

+(BOOL)stringIsNilOrEmpty:(NSString *)string
{
    return !string || [string isEqualToString:@""];
}

+(NSString *)stringByTrimmingString:(NSString  *)string
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [string stringByTrimmingCharactersInSet:whitespace];
}

+(NSString *)stringByRemovingBlanks:(NSString *)string
{
    NSString *withoutBlanks = [string stringByReplacingOccurrencesOfString:@"[ ]+" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    return [withoutBlanks stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+(NSString *)stringWithFormat:(NSString *)format arguments:(NSArray *)args
{
    NSString *formatted;
    switch (args.count) {
        case 0:
            formatted = format;
            break;
        case 1:
            formatted = [NSString stringWithFormat:format, args[0]];
            break;
        case 2:
            formatted = [NSString stringWithFormat:format, args[0], args[1]];
            break;
        case 3:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2]];
            break;
        case 4:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3]];
            break;
        case 5:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4]];
            break;
        case 6:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5]];
            break;
        case 7:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5], args[6]];
            break;
        case 8:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]];
            break;
        case 9:
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]];
            break;
        default:
            // Ten or more elements, just use the first 10 elements
            formatted = [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]];
            break;
    }
    
    if (args.count > 10) {
        NSAssert(args.count <= 10, @"[WRN] More than 10 (%lu) elements in array.", (unsigned long)args.count);
    }
    
    return formatted;
}

@end
