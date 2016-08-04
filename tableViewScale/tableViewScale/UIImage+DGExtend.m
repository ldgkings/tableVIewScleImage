//
//  UIImage+DGExtend.m
//  微博项目
//
//  Created by etcxm on 15/9/24.
//  Copyright (c) 2015年 etcxm. All rights reserved.
//

#import "UIImage+DGExtend.h"

@implementation UIImage (DGExtend)

+ (instancetype)imageWithRenderingName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype )resizableImage:(UIImage *)image
{
    
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;

return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, top, left) resizingMode:UIImageResizingModeStretch];

}

/**
 * 根据颜色返回一个固定大小和有圆角的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    if (radius > 0.0f && radius <= size.width && radius <= size.height) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
        [color setFill];
        [path fill];
    } else {
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    }
    CGContextRestoreGState(ctx);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 * 根据颜色返回 一个固定大小的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    return [UIImage imageWithColor:color size:size cornerRadius:0.0f];
}

/**
 * 根据颜色返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}


// 给一个背景图片和logo 返回一个打水印的图片
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo
{
    
    UIImage *bgImage = [UIImage imageNamed:bg];
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


// 返回一个带边框的裁剪的图片
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 传过来一个view就可以截图
+ (instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    
    // 将view的图层画到新的图片上
    [view.layer renderInContext:(ctx)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




@end
