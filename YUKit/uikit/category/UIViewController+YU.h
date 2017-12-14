//
//  UIViewController+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YU)
-(UIView*)yu_parentTarget;
-(CAAnimationGroup*)yu_animationGroupForward:(BOOL)_forward;
-(UIViewController *)yu_lastPresentedViewController;
@end


@interface UIViewController (KNSemiModal)
-(void)yu_presentSemiViewController:(UIViewController*)vc;

-(void)yu_presentSemiView:(UIView*)vc;

-(void)yu_dismissSemiModalView;


@end
