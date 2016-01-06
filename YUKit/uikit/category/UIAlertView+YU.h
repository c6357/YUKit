//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <BlocksKit+UIKit.h>

@interface UIAlertView (YU)

+(void)showMsg:(NSString*)msg;

+(void)ShowInfo:(NSString*)info time:(CGFloat)time;

+(UIAlertView*)ShowConfirmInfo:(NSString*)info delegate:(id)delegate;

//+ (void)alertView:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock;
//
//+ (void)alertView:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock;

@end
