//
//  UIImage+Scale.h
//  LiKeDaren
//
//  Created by mac on 13-11-12.
//  Copyright (c) 2013年 zhoufu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize WithImage:(UIImage*)image;
@end
