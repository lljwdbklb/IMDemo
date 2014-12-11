//
//  WJChatCell.m
//  IMDemo
//
//  Created by WhoJun on 14/12/11.
//  Copyright (c) 2014年 WhoJun. All rights reserved.
//

#import "WJChatCell.h"

#import "WJChatFrame.h"

#import "UIImage+Ljj.h"

//经常用到保存在内存
static UIImage *SenderTextNodeBkg;
static UIImage *ReceiverTextNodeBkg;

@interface WJChatCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *contentChatView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatConstraintH;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation WJChatCell


- (void)awakeFromNib {
    if (!SenderTextNodeBkg) {
        [[self class] cellLoadImage];
    }
}

+ (void)cellLoadImage {
    SenderTextNodeBkg = [UIImage resizingImageWithNamed:@"chats_me" xPic:0.5 yPic:0.53];
    ReceiverTextNodeBkg = [UIImage resizingImageWithNamed:@"chats_you" xPic:0.5 yPic:0.53];
}

- (void)setChatFrame:(WJChatFrame *)chatFrame {
    _chatFrame = chatFrame;
    
    UIView *contentView = chatFrame.frameParams[@"contentView"];
    UIView *content = [self.contentChatView viewWithTag:303];
    if (![content isEqual:contentView]) {//content
        [content removeFromSuperview];
    } else {
        return;
    }
    [self.contentChatView addSubview:chatFrame.frameParams[@"contentView"]];

    CGSize titleSize =[chatFrame.frameParams[@"contentSize"] CGSizeValue];
    self.chatConstraintW.constant = titleSize.width;
    self.chatConstraintH.constant = titleSize.height;
    
    
    
    if (!chatFrame.isMe) {
        [self.backgroundImageView setImage:ReceiverTextNodeBkg];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        [self.backgroundImageView setImage:SenderTextNodeBkg];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
    }
}
@end
