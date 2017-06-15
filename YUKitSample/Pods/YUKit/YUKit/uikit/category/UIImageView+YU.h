//
//  UIImageView+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YU)
/**
 Methot that create a crop image from that imageView
 */
- (UIImageView *) createCrop: (CGRect) crop;

/**
 Method that crates a view that contains that ImageView
 */
- (UIView *)createView;

@end
