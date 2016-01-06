//
//  UIViewController+BaseClass.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIViewController+BaseClass.h"
#import "YUKit.h"
#import "UIImage+YU.h"
#import "UIAlertView+YU.h"
#import "UIView+YU.h"
#import "NSObject+YU.h"

@implementation UIViewController (BaseClass)

- (BOOL)checkUserExistAndPromptForLoginWhenNonexist
{
//    UserData *userData = [UserDataManager currentUser];
//    if (!userData) {
//        [self.lastPresentedViewController presentViewController:[LoginViewController controllerByDefaultStoryBoard] animated:YES completion:^{
//            ;
//        }];
//        return NO;
//    }
    return YES;
}


- (void)setNormalNavBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f]};
    self.navigationItem.hidesBackButton = NO;
    
}

- (void)setTranslucentNavBar
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(APP_WIDTH(), 64)] forBarMetrics:UIBarMetricsCompact];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:24.f]};
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = self.backBarItem;
}



- (UIBarButtonItem *)backBarItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"Back Arrow-1"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(navPop:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)navPop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIViewController *)lastPresentedViewController
{
    return [self getChildPresentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)getChildPresentViewController:(UIViewController *)parentViewController
{
    if (parentViewController.presentedViewController == nil) {
        return parentViewController;
    } else {
        return [self getChildPresentViewController:parentViewController.presentedViewController];
    }
}

////////////////// 弹出框 ///////////////////////
/****************  提示信息框  **********************/

-(void)showMessage:(NSString*)msg
{
//    [[UIApplication sharedApplication].delegate.window makeToast:content duration:2.0 position:@"center"];
    
    [UIAlertView ShowInfo:SafeString(msg) time:1.5];
}

//-(void)showWithStatus:(NSString*)str{
//    [self exeBlock:^{
//        [SVProgressHUD dismiss];
//    } after:showStateTime];
//    if (IsSafeString(str)) {
//          [SVProgressHUD showWithStatus:str];
//    }else{
//          [SVProgressHUD show];
//    }
//}
//
//-(void)dismiss:(void(^)())block{
//    [self exeBlock:^{
//        [SVProgressHUD dismiss];
//        if ( block) {
//             block();
//        }
//    } after:(0.5)];
//}


-(void)hiddenTabBar:(void(^)())completion{
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = self.view.H;
    [UIView animateWithDuration:.35 animations:^{
        self.tabBarController.tabBar.frame = frame;
    } completion:^(BOOL finished) {
        [self afterBlock:^{
            if (completion) {
                completion();
            }
        } after:0.35];
//        self.tabBarController.tabBar.hidden = YES;
    }];
    
}

-(void)showTabBar:(void(^)())completion{
    self.tabBarController.tabBar.hidden = NO;
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = (self.view.H) - 49;
    [UIView animateWithDuration:.35 animations:^{
        self.tabBarController.tabBar.frame = frame;
    } completion:^(BOOL finished) {
        [self afterBlock:^{
            if (completion) {
                completion();
            }
        } after:0.35];
    }];
}

@end
