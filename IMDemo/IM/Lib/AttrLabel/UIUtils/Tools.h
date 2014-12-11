//
//  Tools.h
//  SendMessageMyDemo
//
//  Created by mmx on 14-7-21.
//  Copyright (c) 2014年 ztgame. All rights reserved.
//

#ifndef SendMessageMyDemo_Tools_h
#define SendMessageMyDemo_Tools_h
#import"UIViewExt.h"
#import "UIView+ViewController.h"
#import "SVProgressHUD.h"
#import  "NSString+URLEncoding.h"
#import "NSDictionary+Addition.h"
#import "UIWebView+VideoControl.h"
#import "AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Base64.h"
#import "NSArray+SortArray.h"
//获取物理屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kIos7   [[[UIDevice currentDevice] systemVersion] floatValue]>=7
#define kColorRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define kWindow  [[[UIApplication sharedApplication] windows] lastObject]


#endif
