//
//  CustomMethod.h
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "OHAttributedLabel.h"
#import "SCGIFImageView.h"

@interface CustomMethod : NSObject

+ (NSString *)escapedString:(NSString *)oldString;
+ (void)drawImage:(OHAttributedLabel *)label;
+ (NSMutableArray *)addHttpArr:(NSString *)text;
+ (NSMutableArray *)addPhoneNumArr:(NSString *)text;
+ (NSMutableArray *)addEmailArr:(NSString *)text;
+ (NSString *)transformString:(NSString *)originalStr  emojiDic:(NSDictionary *)_emojiDic;

@end
