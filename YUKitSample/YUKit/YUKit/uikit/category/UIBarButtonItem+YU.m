//
//  UIBarButtonItem+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIBarButtonItem+YU.h"
#import "UIView+YU.h"
#import "NSString+YU.h"
#import "UIButton+YU.h"

@implementation UIBarButtonItem (YU)

+(UIBarButtonItem *)buttonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action{
    
    return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

+(UIBarButtonItem *)buttonItemWithTitle:(NSString*)title target:(id)target action:(SEL)action{
    
    return [self buttonItemWithTitle:title font:[UIFont systemFontOfSize:13] target:target action:action];
}

+(UIBarButtonItem *)buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  target:(id)target action:(SEL)action{
    
    return [self buttonItemWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:13] target:target action:action];
}

+(UIBarButtonItem *)buttonItemWithTitle:(NSString*)title font:(UIFont*)font target:(id)target action:(SEL)action{
    
    return [self buttonItemWithTitle:title titleColor:[UIColor blackColor] font:font target:target action:action];
}

+(UIBarButtonItem *)buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action{
    
    return [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithTitle:title titleColor:titleColor font:font target:target action:action]];
}

+(UIBarButtonItem *)buttonItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment{

    UIButton *button = [UIButton buttonWithTitle:title titleColor:titleColor font:font target:target action:action];
    button.contentHorizontalAlignment = contentHorizontalAlignment;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
