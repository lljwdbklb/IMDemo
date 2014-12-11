//
//  UIImage+Ljj.m
//  WeiBo
//
//  Created by Jun on 13-10-31.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "UIImage+Ljj.h"

#ifndef is4inch
//是否是4寸屏
#define is4inch ([UIScreen mainScreen].bounds.size.height == 568.0)
#endif


@implementation UIImage (Ljj)

+ (instancetype)resizingImageWithNamed:(NSString *)named {
    return [self resizingImageWithNamed:named xPic:0.5 yPic:0.5];
}

+ (instancetype)resizingImageWithNamed:(NSString *)named xPic:(CGFloat)xPic yPic:(CGFloat)yPic{
    UIImage *image = [UIImage imageNamed:named];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * xPic topCapHeight:image.size.height * yPic];
    return image;
}

+ (instancetype)fullScreenWithName:(NSString *)name {
    if (is4inch) {
        NSString * ex = [name pathExtension];
        name = [name stringByDeletingPathExtension];
        name = [name stringByAppendingString:@"-568h@2x"];
        name = [name stringByAppendingPathExtension:ex];
    }
    return [UIImage imageNamed:name];
}

- (UIImage *)clipCircleFromRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(cxt, rect);
    CGContextClip(cxt);
    [self drawInRect:(CGRect){CGPointZero,self.size}];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)clipRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextAddRect(cxt, (CGRect){CGPointZero,rect.size});
    CGContextClip(cxt);
    [self drawInRect:(CGRect){{-rect.origin.x,-rect.origin.y},self.size}];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageScaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
@end
