//
//  UIAlertView+YU.h
//  YUKitSample
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (YU)

+ (void)alertView:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock;

+ (void)alertView:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock;

@end
