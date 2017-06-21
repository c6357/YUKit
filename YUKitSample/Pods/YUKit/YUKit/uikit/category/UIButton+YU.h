//
//  UIButton+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YU)

+(UIButton*)buttonWithImage:(UIImage*)image  target:(id)target action:(SEL)action;

+(UIButton*)buttonWithImage:(UIImage*)image frame:(CGRect)frame  target:(id)target action:(SEL)action;

+(UIButton *)buttonWithTitle:(NSString*)title target:(id)target action:(SEL)action;

+(UIButton *)buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor target:(id)target action:(SEL)action;

+(UIButton *)buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action;

+(UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action;


/**
 改变 bounds的点击范围

 注意：当hidden = YES button时间依然响应
 改问题还没排上日程
 
 */

- (void)setEnlargeEdge:(CGFloat) size;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
