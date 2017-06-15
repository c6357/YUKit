//
//  UINavigationController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UINavigationController+YU.h"

//IOS7
#define CURRENT_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_EARLIER_IOS7 ( CURRENT_VERSION < 7.0)

@implementation UINavigationController (YU)
- (float) calculateYPosition
{
    float yPosition=0;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (!self.navigationBarHidden) {
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)){
            yPosition += self.navigationBar.frame.size.height;
        }else{
            yPosition += self.navigationBar.frame.size.width;
        }
    }
    
    if (IS_EARLIER_IOS7 && ![UIApplication sharedApplication].statusBarHidden){
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)){
            yPosition += [UIApplication sharedApplication].statusBarFrame.size.height;
        }else{
            yPosition += [UIApplication sharedApplication].statusBarFrame.size.width;
        }
    }
    
    return yPosition;
}

- (BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
