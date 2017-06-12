
//
//  UIResponder+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIResponder+YU.h"

@implementation UIResponder (YU)

- (UIViewController *)recentlyController
{
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:[UIViewController class]];
    
    return controller;
}


- (UINavigationController *)recentlyNavigationContoller
{
    UINavigationController *controller = (UINavigationController *)[self objectInResponder:self.nextResponder class:[UINavigationController class]];
    
    return controller;
}


- (UIResponder *)objectInResponder:(UIResponder *)responder class:(Class)class{
    if ([responder isKindOfClass:class]) {
        return responder;
    } else {
        return [self objectInResponder:responder.nextResponder class:class];
    }
}

@end
