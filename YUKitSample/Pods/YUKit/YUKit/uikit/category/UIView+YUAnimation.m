//
//  UIView+YUAnimation.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIView+YUAnimation.h"
#import "NSObject+YU.h"

#define DURATION 0.7f

@implementation UIView (animation)
+ (void) transitionWithType:(AnimationType)type WithSubtype:(Animationsubtype)subtype ForView : (UIView *) view  duration:(double)duration completion:(void(^)())completion{
    
    [self transitionWithType:type WithSubtype:subtype ForView:view duration:duration];
    
    [self afterBlock:^{
        if (completion) {
            completion();
        }
    } after:duration];
}

+ (void) transitionWithTypeString:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view duration:(double)duration completion:(void(^)())completion{
    [self transitionWithTypeString:type WithSubtype:subtype ForView:view duration:duration];
    
    [self afterBlock:^{
        if (completion) {
            completion();
        }
    } after:duration];
}

+ (void) transitionWithType:(AnimationType)type WithSubtype:(Animationsubtype)subtype ForView : (UIView *) view duration:(double)duration
{
    AnimationType animationType = type;
    
    NSString *subtypeString;
    
    switch (subtype) {
        case Left:
            subtypeString = kCATransitionFromLeft;
            break;
        case Bottom:
            subtypeString = kCATransitionFromBottom;
            break;
        case Right:
            subtypeString = kCATransitionFromRight;
            break;
        case Top:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    
    switch (animationType) {
        case Fade:
            [self transitionWithTypeString:kCATransitionFade WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case Push:
            [self transitionWithTypeString:kCATransitionPush WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case Reveal:
            [self transitionWithTypeString:kCATransitionReveal WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case MoveIn:
            [self transitionWithTypeString:kCATransitionMoveIn WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case Cube:
            [self transitionWithTypeString:@"cube" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case SuckEffect:
            [self transitionWithTypeString:@"suckEffect" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case OglFlip:
            [self transitionWithTypeString:@"oglFlip" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case RippleEffect:
            [self transitionWithTypeString:@"rippleEffect" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case PageCurl:
            [self transitionWithTypeString:@"pageCurl" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case PageUnCurl:
            [self transitionWithTypeString:@"pageUnCurl" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithTypeString:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithTypeString:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:view duration:duration];
            break;
            
        case CurlDown:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
    
}

#pragma UIView实现动画
+ (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}




#pragma CATransition动画实现
+ (void) transitionWithTypeString:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view duration:(double)duration
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration?:DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:@"animation"];
    
}


@end
