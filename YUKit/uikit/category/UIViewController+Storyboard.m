//
//  UIViewController+Storyboard.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

+ (instancetype)yu_controllerByDefaultStoryBoard
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
    return [story instantiateInitialViewController];
}



@end
