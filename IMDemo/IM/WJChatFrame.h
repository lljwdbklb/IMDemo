//
//  WJChatFrame.h
//  IMDemo
//
//  Created by WhoJun on 14/12/11.
//  Copyright (c) 2014年 WhoJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJChatFrame : NSObject
- (instancetype)initWithMsg:(id)msg;
@property(copy, nonatomic)id msg;

+ (NSDictionary *)emoDict;

@property (readonly, nonatomic) NSString *identifier;
@property (readonly, assign, nonatomic, getter=isMe) BOOL me;
@property (readonly,copy,nonatomic)NSDictionary *frameParams;
@end
