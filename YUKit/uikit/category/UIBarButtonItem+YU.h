//
//  UIBarButtonItem+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YU)

+(UIBarButtonItem *)yu_buttonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;

+(UIBarButtonItem *)yu_buttonItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;

+(UIBarButtonItem *)yu_buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  target:(id)target action:(SEL)action;

+(UIBarButtonItem *)yu_buttonItemWithTitle:(NSString*)title font:(UIFont*)font target:(id)target action:(SEL)action;

+(UIBarButtonItem *)yu_buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action;

+(UIBarButtonItem *)yu_buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

@end
