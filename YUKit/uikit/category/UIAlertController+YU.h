//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (YU)

+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock;

+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock;

+ (UIViewController*)lastPresentedViewController;

@end
