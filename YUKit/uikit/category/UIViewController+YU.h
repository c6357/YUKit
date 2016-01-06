//
//  UIViewController+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YU)

-(void)presentSemiViewController:(UIViewController*)vc;

-(void)presentSemiView:(UIView*)vc;

-(void)dismissSemiModalView;

@end


@interface UIViewController (KNSemiModal)

@end