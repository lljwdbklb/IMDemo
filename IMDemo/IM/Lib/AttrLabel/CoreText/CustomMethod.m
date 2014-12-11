//
//  CustomMethod.m
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import "CustomMethod.h"

@implementation CustomMethod

+ (NSString *)escapedString:(NSString *)oldString
{
    NSString *escapedString_lt = [oldString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    NSString *escapedString = [escapedString_lt stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return escapedString;
}


+ (void)drawImage:(OHAttributedLabel *)label
{
    for (NSArray *info in label.imageInfoArr) {
//        NSLog(@"%@",info);
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
        imageView.frame = CGRectFromString([info objectAtIndex:2]);
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [label addSubview:imageView];//label内添加图片层
        [label bringSubviewToFront:imageView];
    }
    
//    for (NSDictionary *info in label.images) {
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
//        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
//        SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
//        imageView.frame = CGRectFromString([info objectAtIndex:2]);
//        [label addSubview:imageView];//label内添加图片层
//        [label bringSubviewToFront:imageView];
//    }
}


#pragma mark - 正则匹配电话号码，网址链接，Email地址
+ (NSMutableArray *)addHttpArr:(NSString *)text
{
    //匹配网址链接
    NSString *regex_http = @"(https?|ftp|file)+://[^\\s]*";
    NSArray *array_http = [text componentsMatchedByRegex:regex_http];
    NSMutableArray *httpArr = [NSMutableArray arrayWithArray:array_http];
    return httpArr;
}

+ (NSMutableArray *)addPhoneNumArr:(NSString *)text
{
    //匹配电话号码
    NSString *regex_phonenum = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";
    NSArray *array_phonenum = [text componentsMatchedByRegex:regex_phonenum];
    NSMutableArray *phoneNumArr = [NSMutableArray arrayWithArray:array_phonenum];
    return phoneNumArr;
}

+ (NSMutableArray *)addEmailArr:(NSString *)text
{
    //匹配Email地址
    NSString *regex_email = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*";
    NSArray *array_email = [text componentsMatchedByRegex:regex_email];
    NSMutableArray *emailArr = [NSMutableArray arrayWithArray:array_email];
    return emailArr;
}

+ (NSString *)transformString:(NSString *)originalStr emojiDic:(NSDictionary *)_emojiDic
{
    //匹配表情，将表情转化为html格式
    NSString *text = originalStr;
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
    if ([array_emoji count]) {
        for (NSString *str in array_emoji) {
            NSRange range = [text rangeOfString:str];
            NSString *i_transCharacter = [_emojiDic objectForKey:str];
            if (i_transCharacter) {
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='27' height='27'>",i_transCharacter];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:imageHtml];
            }
        }
    }
    //返回转义后的字符串
    return text;
}

@end
