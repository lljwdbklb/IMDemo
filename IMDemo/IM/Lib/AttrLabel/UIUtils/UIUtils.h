//
//  UIUtils.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

//将字符串格式化为Date对象
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;
//将日期格式化为NSString对象
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

//计算目录下面所有文件的大小
+ (long long)countDirectorySize:(NSString *)directory;
+(NSString *)parserText:(NSString *)text;


+ (NSString *)parseSourceText:(NSString *)source;

@end
