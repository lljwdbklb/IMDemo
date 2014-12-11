//
//  UIView+ViewController.m
//  微博项目
//
//  Created by 谭鹏昭 on 13-11-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *)viewController
{
    id next = [self nextResponder];
    
    while (next != nil) {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        next = [next nextResponder];
    }
    
    return nil;
}

@end
