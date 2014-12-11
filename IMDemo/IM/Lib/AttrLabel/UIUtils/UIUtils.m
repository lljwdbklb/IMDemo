//
//  UIUtils.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIUtils.h"
#import "NSString+URLEncoding.h"
#import "RegexKitLite.h"

@implementation UIUtils

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *local = [NSLocale currentLocale];
    [dateFormatter setLocale:local];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
  
    
    return datestring;
}

+ (long long)countDirectorySize:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //        NSNumber *filesize = [attribute objectForKey:NSFileSize];
        long long size = [attribute fileSize];
        
        sum += size;
    }
    
    return sum;
}


+(NSString *)parserText:(NSString *)text
{
    // 正则表达式
    NSString *regex = @"@\\w+|#\\w+#|(http|https)://(([A-Za-z.0-9/?=&'_])+)";
    // 找出替换的内容
    NSArray *values = [text componentsMatchedByRegex:regex];
    
    for (id value in values) {
        
        // 存在中文，必须进行编码
        NSString *encode =[value URLEncodedString];
        // 替换的内容
        NSString *replace = [NSString stringWithFormat:@"<a href='%@'>%@</a>", encode, value];
        // 替换换字符串  1R2T3A -> 1.2T3A -> 1.2.3A
        text = [text stringByReplacingOccurrencesOfString:value withString:replace];
    }
    
    return text;
}

+ (NSString *)parseSourceText:(NSString *)source {
    NSString *regex = @">\\w+<";
    NSArray *array = [source componentsMatchedByRegex:regex];
    if (array.count > 0) {
        //>新浪微博<
        NSString *s = [array objectAtIndex:0];
        NSRange range;
        range.location = 1;
        range.length = s.length - 2;
        NSString *result = [s substringWithRange:range];
        
        return result;
    }
    
    return nil;
}

@end
