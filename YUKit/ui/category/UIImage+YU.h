//
//  UIImage+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YU)

UIImage* imageWithContentsOfFile(NSString *file,NSString *ext);

UIImage* imageNamed(NSString *_pointer);

UIImage* ResizableImage(NSString *name,CGFloat top,CGFloat left,CGFloat bottom,CGFloat right);

UIImage* ResizableImageWithMode(NSString *name,CGFloat top,CGFloat left,CGFloat bottom,CGFloat right,UIImageResizingMode mode);


// 缩放图片 不剪切
- (UIImage *)resizeImageWithNewSize:(CGSize)newSize;

//剪切图片
- (UIImage *)croppedImage:(CGRect)rect;

//等比，居中剪切
- (UIImage *)croppedCenterImage:(CGSize)size;

//顺时针多少度 弧度 0 ~ 2M_PI
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

//顺时针多少度 度 0 ~ 360
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

//获取该图片的大概颜色
-(UIColor*)mostColor;

//
-(UIImage *)imageRotation:(UIImageOrientation)orientation;


-(UIImage *)imageWithTintColor:(UIColor *)tintColor;


- (UIImage *)resizedImageWithBounds:(CGSize)bounds;


+(UIImage *)imageWithUIView:(UIView*) view;


+(UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size;


/**
 * 从资源文件中获取UIImage (PNG 格式)
 * @param imageName 图片名称(不包含后缀名)
 * @return UIImage
 */
+(UIImage*)imagePNGWithImageName:(NSString *)imageName;

/**
 * 从Bundle资源文件中获取UIImage
 * @param imageName 图片名称(包括后缀名)
 * @return UIImage
 */
+(UIImage*)imagesNamedFromCustomBundle:(NSString *)imageName;

/**
 * 对图片进行缩放
 * @param img  图片句柄
 * @param size 指定图片的宽和高　size.width|size.height
 **/
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;


//图片上添加小红点
+(UIImage*)imageAddRedDot:(NSString*)imageName;



//根据颜色返回图片
+(UIImage *)imageWithColor:(UIColor*)color;



@end
