//
//  UIImage+DGExtend.h
//  微博项目
//
//  Created by etcxm on 15/9/24.
//  Copyright (c) 2015年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DGExtend)

+ (instancetype)imageWithRenderingName:(NSString *)imageName;

+ (instancetype )resizableImage:(UIImage *)image;

// 根据颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

// 给一个背景图片和logo 返回一个打水印的图片
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

// 返回一个带边框的裁剪的图片
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

// 屏幕截图
+ (instancetype)captureWithView:(UIView *)view;

@end
