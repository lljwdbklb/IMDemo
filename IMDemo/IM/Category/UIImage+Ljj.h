//
//  UIImage+Ljj.h
//  WeiBo
//
//  Created by Jun on 13-10-31.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ljj)
/**
 *
 *  拉伸图片
 *
 *  @param named    沙盒中得图片名
 *
 *  @return 修改后格式的对象
 */
+ (instancetype)resizingImageWithNamed:(NSString *)named;

/**
 *
 *  拉伸图片
 *
 *  @param named    沙盒中得图片名
 *  @param xPic     图片X轴比例
 *  @param yPic     图片Y轴比例
 *
 *  @return 修改后格式的对象
 */
+ (instancetype)resizingImageWithNamed:(NSString *)named xPic:(CGFloat)xPic yPic:(CGFloat)yPic;

/**
 *  适配屏幕的图片
 *
 *
 *
 *  @param name 图片名+后缀名
 *
 *  @return 返回图片
 */
+ (instancetype)fullScreenWithName:(NSString *)name;
/**
 *  剪裁一个圆
 *
 *  @param rect 剪裁位置
 *
 *  @return 返回一个剪裁后的新图像
 */
- (UIImage *)clipCircleFromRect:(CGRect)rect;
/**
 *  剪裁一个矩形
 *
 *  @param rect 剪裁位置
 *
 *  @return 返回一个剪裁后的新图像
 */
- (UIImage *)clipRect:(CGRect)rect;

/**
 *  当前图片压缩
 *
 *  @param newSize 压缩后的尺寸
 *
 *  @return 返回压缩图片
 */
- (UIImage *)imageScaledToSize:(CGSize)newSize;
@end
