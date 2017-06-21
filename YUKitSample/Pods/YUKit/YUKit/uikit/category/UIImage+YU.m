//
//  UIImage+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIImage+YU.h"
#import "NSString+YU.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)

#else

#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast

#endif


CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


@implementation UIImage (YU)
#pragma mark -
#pragma mark - initialize
UIImage* UIImageWithName(NSString *fileName){
    return [UIImage imageNamed:fileName];
}

UIImage* UIImageNamedWithBundleOFFile(NSString *bundleName,NSString *name,NSString *ext)
{
    NSString *_bundleName = bundleName;

    if (-1 == [bundleName lastIndexOf:@".bundle"] ) {
        _bundleName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    }
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:_bundleName];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *img_path = [bundle pathForResource:name ofType:ext];
    
    return [UIImage imageWithContentsOfFile:img_path];
}

UIImage* UIImageWithContentsOfPNGFile(NSString *fileName){
    assert(fileName.length);
    return UIImageWithContentsOfFile(fileName,@"png");
}

UIImage* UIImageWithContentsOfJPGFile(NSString *fileName){
    return UIImageWithContentsOfFile(fileName,@"jpg");
}

UIImage* UIImageWithContentsOfFile(NSString *fileName,NSString *ext){
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:ext]];
}

+(UIImage *)imageWithView:(UIView*)view{

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//根据颜色返回图片
+(UIImage *)imageWithColor:(UIColor*)color
{
    return [self imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+(UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

//- (UIImage *)imageWithTintColor:(UIColor *)tintColor
//{
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
//    [tintColor setFill];
//    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
//    UIRectFill(bounds);
//    
//    [self drawInRect:bounds blendMode:kCGBlendModeDestinationOut alpha:1.f];
//    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return tintedImage;
//}


#pragma mark -
#pragma mark - 
UIImage* imageWithCapInsets(NSString *name,CGFloat top,CGFloat left,CGFloat bottom,CGFloat right){
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)];
}

UIImage* imageWithCapInsetsAndResizingMode(NSString *name,CGFloat top,CGFloat left,CGFloat bottom,CGFloat right,UIImageResizingMode mode){
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode];
}

- (UIImage *)imageByResizeToMultiple:(CGFloat)multiple
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * multiple, self.size.height * multiple));
    [self drawInRect:CGRectMake(0, 0, self.size.width * multiple, self.size.height * multiple)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)imageByResizeToSize:(CGSize)size{
    
    CGFloat newWidth  = size.width;
    CGFloat newHeight = size.height;
    float width       = self.size.width;
    float height      = self.size.height;
    
    if (width == 0 || height == 0){
        return self;
    }
    
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
//        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resized;
    }
    return self;
}

- (UIImage *)imageByResizeWithBounds:(CGSize)bounds
{
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio = MAX(horizontalRatio, verticalRatio);
    
    CGSize newSize = CGSizeMake(self.size.width * ratio,self.size.height * ratio);
    NSLog(@"%f", self.size.width);
    NSLog(@"%f", self.size.height);
    NSLog(@"%f", horizontalRatio);
    NSLog(@"%f", verticalRatio);
    NSLog(@"%f", newSize.width);
    NSLog(@"%f", newSize.height);
    
    //  NSLog(@"%f", newSize.height);
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    [self drawInRect:CGRectMake(0, 0, newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageByCropToRect:(CGRect)rect
{
    CGImageRef imageRef   = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

//等比，居中剪切
- (UIImage *)imageByCropCenterToRect:(CGSize)size{

    CGFloat scaleW = self.size.width/size.width;
    CGFloat scaleH = self.size.height/size.height;
    if(self.size.width > 1 || self.size.height > 1){
        if(scaleH < scaleW){
            //得到要剪切的大小
            CGSize scaleSize = CGSizeMake(size.width*scaleH, size.height*scaleH);
            //剪切
            CGRect rect      = CGRectMake((self.size.width-scaleSize.width)/2, 0, scaleSize.width, scaleSize.height);
            UIImage *img     = [self imageByCropToRect:rect];
            return img;
        }else{
            
            //得到要剪切的大小
            CGSize scaleSize = CGSizeMake(size.width*scaleW, size.height*scaleW);
            //剪切
            CGRect rect      = CGRectMake(0, (self.size.height-scaleSize.width)/2, scaleSize.width, scaleSize.height);
            UIImage *img     = [self imageByCropToRect:rect];
            return img;
        }
    }
    return self;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox   = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t      = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize       = rotatedViewBox.frame.size;

    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (UIImage *)imageRotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX   = 0;
    float translateY   = 0;
    float scaleX       = 1.0;
    float scaleY       = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate     = M_PI_2;
            rect       = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY     = rect.size.width/rect.size.height;
            scaleX     = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate     = 3 * M_PI_2;
            rect       = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY     = rect.size.width/rect.size.height;
            scaleX     = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate     = M_PI;
            rect       = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate     = 0.0;
            rect       = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

-(UIColor*)imageMostColor{
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red    = data[offset];
            int green  = data[offset+1];
            int blue   = data[offset+2];
            int alpha  = data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor        = nil;
    
    NSArray *MaxColor        = nil;
    NSUInteger MaxCount      = 0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

- (UIImage*)imageChangeByColor:(UIColor*)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, YES, [[UIScreen mainScreen] scale]);
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [self size];
    
    // Retrieve source image and begin image context
    CGSize itemImageSize = [self size];
    CGPoint itemImagePosition;
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
    
    UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Setup shadow
    // Setup transparency layer and clip to mask
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [self CGImage]);
    // Fill and end the transparency layer
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(color.CGColor);
    CGColorSpaceModel model = CGColorSpaceGetModel(colorSpace);
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    
    if(model == kCGColorSpaceModelMonochrome)
    {
        CGContextSetRGBFillColor(c, colors[0], colors[0], colors[0], colors[1]);
    }else{
        CGContextSetRGBFillColor(c, colors[0], colors[1], colors[2], colors[3]);
    }
    contextRect.size.height = -contextRect.size.height;
    contextRect.size.height -= 15;
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



#pragma mark -
#pragma mark - Code
// 参考文档
// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

+ (UIImage *)generateQRCode:(NSString *)code image:(UIImage*)image width:(CGFloat)width height:(CGFloat)height {
    
    //1.生成coreImage框架中的滤镜来生产二维码
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    //Value必须传入数据流
    
    [filter setValue:[code dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    //4.获取生成的图片
    CIImage *ciImg=filter.outputImage;
    //放大ciImg,默认生产的图片很小
    
#if  0
    //5.设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //5.1设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImg forKey:@"inputImage"];
    //    [colorFilter setValue:[CIColor colorWithRed:1 green:0 blue:0] forKey:@"inputColor0"];
    //    [colorFilter setValue:[CIColor colorWithRed:0 green:0 blue:1] forKey:@"inputColor1"];
    //5.3获取生存的图片
    ciImg=colorFilter.outputImage;
    
    CGAffineTransform scale=CGAffineTransformMakeScale(10, 10);
    ciImg=[ciImg imageByApplyingTransform:scale];
    UIImage *img=[UIImage imageWithCIImage:ciImg];
#else
    CGFloat scaleX = width / ciImg.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / ciImg.extent.size.height;
    CIImage *transformedImage = [ciImg imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    //6.在中心增加一张图片
    UIImage *img=[UIImage imageWithCIImage:transformedImage];
#endif
    
    //7.生存图片
    //7.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //7.2将二维码的图片画入
    //BSXPCMessage received error for message: Connection interrupted   why??
    [img drawInRect:CGRectMake(10, 10, img.size.width-20, img.size.height-20)];
    
    
    //7.3在中心划入其他图片
    UIImage *centerImg = [UIImage imageNamed:@"user_hme_icon"];
    CGFloat centerW=MIN(36, width/6);
    CGFloat centerH=MIN(36, height/6);
    CGFloat centerX=(width-centerW)*0.5;
    CGFloat centerY=(height - centerH)*0.5;
    
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    
    //7.4获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    
    //7.5关闭图像上下文
    UIGraphicsEndImageContext();
    //设置图片
    return finalImg;
}



+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}


// 每隔4个字符空两格
+ (NSString *)imageFormatCode:(NSString *)code {
    //    NSMutableArray *chars = [[NSMutableArray alloc] init];
    
    NSMutableString *chars = [NSMutableString new];
    
    for (int i = 0; i < [code length]; i++) {
        
        if (i %4 == 0 && (i>1 && i<[code length])) {
            [chars appendString:@"  "];
        }else{
            [chars appendString:@""];
        }
        
        NSString * c = [code substringWithRange:NSMakeRange(i,1)];
        [chars appendString:c];
    }
    
    return chars;
    
    //    for (int i = 0, j = 0 ; i < [code length]; i++, j++) {
    //        [chars addObject:[NSNumber numberWithChar:[code characterAtIndex:i]]];
    //        if (j == 3) {
    //            j = -1;
    //            [chars addObject:[NSNumber numberWithChar:' ']];
    //            [chars addObject:[NSNumber numberWithChar:' ']];
    //        }
    //    }
    //
    //    int length = (int)[chars count];
    //    char str[length];
    //    for (int i = 0; i < length; i++) {
    //        str[i] = [chars[i] charValue];
    //    }
    //
    //    NSString *temp = [NSString stringWithUTF8String:str];
    //    return temp;
}
#pragma mark -
- (BOOL)imageHasAlpha:(UIImage *)image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (NSString *)imageToBase64
{
    //UIImage图片转成Base64字符串：
    NSData *data;
    if ([self imageHasAlpha: self]) {
        data = UIImagePNGRepresentation(self);
    } else {
        data = UIImageJPEGRepresentation(self, 1.0f);
    }
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodedImageStr;
}

+ (UIImage *)Base64ToImage:(NSString *)encodedImageStr
{
    //Base64字符串转UIImage图片：
    NSData *decodedImageData = [[NSData alloc]
                                initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}



- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



- (NSString*)saveImagewithName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.1);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    
    [imageData writeToFile:fullPath atomically:NO];
    
    return fullPath;
}


@end
