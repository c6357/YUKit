//
//  UIView+YUAnimation.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (animation)

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;


typedef enum : NSUInteger {
    Left = 1,                   //左
    Bottom,                     //下
    Right,                      //右
    Top,                        //上
} Animationsubtype;


+ (void) transitionWithType:(AnimationType)type WithSubtype:(Animationsubtype)subtype ForView : (UIView *) view  duration:(double)duration;

+ (void) transitionWithTypeString:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view duration:(double)duration;

+ (void) transitionWithType:(AnimationType)type WithSubtype:(Animationsubtype)subtype ForView : (UIView *) view  duration:(double)duration completion:(void(^)())completion;

+ (void) transitionWithTypeString:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view duration:(double)duration completion:(void(^)())completion;

@end
