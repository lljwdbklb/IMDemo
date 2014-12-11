//
//  WJChatFrame.m
//  IMDemo
//
//  Created by WhoJun on 14/12/11.
//  Copyright (c) 2014年 WhoJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJChatFrame.h"


#import "OHAttributedLabel.h"
#import "MarkupParser.h"
#import "CustomMethod.h"
#import "NSAttributedString+Attributes.h"
#import "UIViewExt.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

#define WJContentFont [UIFont systemFontOfSize:18]

#define WJMargin 10

#define WJContentTop 0 //文本内容与按钮上边缘间隔
#define WJContentLeft 10 //文本内容与按钮左边缘间隔
#define WJContentBottom 0 //文本内容与按钮下边缘间隔
#define WJContentRight 10 //文本内容与按钮右边缘间隔
#define WJContentNameH 18

static NSDictionary *emoDict;

@implementation WJChatFrame

+ (NSDictionary *)emoDict {
    if (!emoDict) {
//        NSLog(@"%@",[[NSBundle mainBundle]pathForResource:@"emotions1" ofType:@"plist"]);
        emoDict = [NSMutableDictionary dictionary];
        NSArray *array = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"emotions1" withExtension:@"plist"]];
        for (NSDictionary *dict in array) {
            [(NSMutableDictionary *)emoDict setObject:dict[@"icon"] forKey:dict[@"phrase"]];
        }
    }
    return emoDict;
}

- (instancetype)initWithMsg:(id)msg {
    if (self = [super init]) {
        self.msg = msg;
    }
    return self;
}
- (void)setMsg:(id)msg {
    _msg = msg;
    
    CGFloat screenW = ScreenWidth;
    
    CGFloat cellHeight = 0;
    
    if (!_frameParams) {
        _frameParams = [NSMutableDictionary dictionary];
    }
    
    CGFloat contentW = 0;
    CGFloat contentH = 0;
    
    NSString *text = [CustomMethod transformString:_msg[@"msg"] emojiDic:[[self class] emoDict]/*表情*/];
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup:text];
    [attString setFont:WJContentFont];
    UIView * contentView = [[OHAttributedLabel alloc]initWithFrame:CGRectZero];
    
    [(OHAttributedLabel *)contentView setTextColor:[UIColor whiteColor]];
    [(OHAttributedLabel *)contentView setBackgroundColor:[UIColor clearColor]];
    [(OHAttributedLabel *)contentView setUserInteractionEnabled:NO];
    [(OHAttributedLabel *)contentView setAttString:attString withImages:wk_markupParser.images];
    [contentView setTag:303];
    
    CGSize contentSize = [(OHAttributedLabel *)contentView sizeThatFits:CGSizeMake(screenW - WJMargin * 7/*气泡小尖尖*/ - 40/*头像大小*/, CGFLOAT_MAX)];
    
    contentW = contentSize.width + 4 + WJContentLeft + WJContentRight;
    contentH = contentSize.height + 10 + WJContentTop + WJContentBottom;
    
    CGFloat textW = contentW - WJContentLeft - WJContentRight;
    CGFloat textH = contentH - WJContentTop - WJContentBottom;
    CGFloat textX = WJContentLeft;
    CGFloat textY = WJContentTop;
    [(OHAttributedLabel *)contentView setFrame:CGRectMake(textX, textY, textW, textH)];
    [contentView.layer display];
    [contentView setOrigin:CGPointMake(textX, textY)];
    [contentView setHeight:textH];
    [CustomMethod drawImage:(OHAttributedLabel *)contentView];
    [(NSMutableDictionary *)_frameParams setObject:contentView forKey:@"contentView"];//内容
    [(NSMutableDictionary *)_frameParams setValue:[NSValue valueWithCGSize:CGSizeMake(contentW, contentH)] forKey:@"contentSize"];//pop的大小
    
    cellHeight = MAX(contentH + WJMargin, 55) + WJMargin;
    
    if((_me = [_msg[@"type"] boolValue])) {
        _identifier = @"Me";
    } else {
        _identifier = @"You";
        cellHeight += 22/*名字高度*/;
    }
    
    [(NSMutableDictionary *)_frameParams setObject:@(cellHeight) forKey:@"cellHeight"];
    
}
@end
