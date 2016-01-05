//
//  UIImageView+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIImageView+YU.h"

#define TAG_IMAGE_VIEW 999

@implementation UIImageView (YU)
- (UIImageView *) createCrop: (CGRect) crop
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.image.CGImage, crop);
    UIImageView *imageViewCropped = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    [imageViewCropped setFrame:crop];
    
    [imageViewCropped setFrame:CGRectMake(imageViewCropped.frame.origin.x,
                                          imageViewCropped.frame.origin.y+self.frame.origin.y,
                                          imageViewCropped.frame.size.width,
                                          imageViewCropped.frame.size.height)];
    CGImageRelease(imageRef);
    return imageViewCropped;
}

- (UIView *)createView
{
    UIView *newView = [[UIView alloc] initWithFrame:self.frame];
    [self setTag:TAG_IMAGE_VIEW];
    [self setFrame:self.bounds];
    [newView addSubview:self];
    return newView;
}

@end
