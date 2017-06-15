//
//  UIViewController+BaseClass.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Storyboard.h"

@interface UIViewController (BaseClass)

- (UIViewController *)lastPresentedViewController;

- (BOOL)checkUserExistAndPromptForLoginWhenNonexist;

- (void)setTranslucentNavBar;

- (void)setNormalNavBar;

/****************   顶部提示框  **********************/
-(void)showMessage:(NSString*)msg;

//-(void)showWithStatus:(NSString*)str;
//
//-(void)dismiss:(void(^)())block;

/**
 *  <#Description#>
 *
 *  @param completion <#completion description#>
 */
-(void)hiddenTabBar:(void(^)())completion;

-(void)showTabBar:(void(^)())completion;
@end
