//
//  UIButton+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YU)

+(UIButton*)yu_buttonWithImage:(UIImage*)image  target:(id)target action:(SEL)action;

+(UIButton*)yu_buttonWithImage:(UIImage*)image frame:(CGRect)frame  target:(id)target action:(SEL)action;

+(UIButton *)yu_buttonWithTitle:(NSString*)title target:(id)target action:(SEL)action;

+(UIButton *)yu_buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor target:(id)target action:(SEL)action;

+(UIButton *)yu_buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action;

+(UIButton*)yu_buttonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont*)font target:(id)target action:(SEL)action;


/**
 改变 bounds的点击范围

 注意：当hidden = YES button时间依然响应
 改问题还没排上日程
 
 */

- (void)yu_setEnlargeEdge:(CGFloat) size;

- (void)yu_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;



/**
 <#Description#>

 @param timeLine <#timeLine description#>
 @param title <#title description#>
 @param subTitle <#subTitle description#>
 @param mColor <#mColor description#>
 @param color <#color description#>
 @param block <#block description#>
 */
- (void)yu_startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color done:(void(^)(void))block;
@end
