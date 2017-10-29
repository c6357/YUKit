//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIAlertController+YU.h"

@implementation UIAlertController (YU)

+ (void)yu_defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:submitBlock];
    
    [alertController addAction:cancel];
    [alertController addAction:submit];
    
    [alertController presentViewController:[self yu_lastPresentedViewController] animated:YES completion:completedBlock];
}

+ (void)yu_defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [alertController addAction:cancel];
    
    [alertController presentViewController:[self yu_lastPresentedViewController] animated:YES completion:completedBlock];
}

+ (UIViewController*)yu_lastPresentedViewController
{
    UIViewController *presentedViewController = [self yu_getChildPresentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return presentedViewController;
}

+ (UIViewController*)yu_getChildPresentViewController:(UIViewController *)vc
{
    if (!vc.presentedViewController) {
        return vc;
    } else {
        return [self yu_getChildPresentViewController:vc.presentedViewController];
    }
}

@end
