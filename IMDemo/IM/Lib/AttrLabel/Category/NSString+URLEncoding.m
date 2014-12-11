//
//  NSString+URLEncoding.m
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "NSString+URLEncoding.h"


@implementation NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
                                                                                        kCFStringEncodingUTF8));
  
	return result;	
}

-(NSString *)URLDecodedChineseString
{
    //把NSString 转 CFStringRef
    NSString *urlString=self;
    CFStringRef originalURLString = (__bridge CFStringRef)urlString;
    CFStringRef preprocessedString =
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, originalURLString, CFSTR(""), kCFStringEncodingUTF8);
    CFStringRef urlString1 =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, preprocessedString, NULL, NULL, kCFStringEncodingUTF8);
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, urlString1, NULL);
    //CFStringRef 转 NSString
    urlString = (__bridge NSString*) url;
    //转换后，发现并非NSString 而是NSURL 这很奇怪 所以再转一次
    if ([urlString isKindOfClass:[NSURL class]]) {
        NSURL *url2 = (__bridge NSURL*) url;;
        urlString = [url2 absoluteString];
    }
    return urlString;
}
@end
