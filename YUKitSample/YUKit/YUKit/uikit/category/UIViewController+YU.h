//
//  UIViewController+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YU)
-(UIView*)parentTarget;
-(CAAnimationGroup*)animationGroupForward:(BOOL)_forward;




@end


@interface UIViewController (KNSemiModal)
-(void)presentSemiViewController:(UIViewController*)vc;

-(void)presentSemiView:(UIView*)vc;

-(void)dismissSemiModalView;


@end