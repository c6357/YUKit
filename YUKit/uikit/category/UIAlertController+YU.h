//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (YU)
/**
 alertController title
 */
@property (nonatomic, strong) UILabel *yu_titleLabel;

/**
 alertController message
 */
@property (nonatomic, strong) UILabel *yu_messageLabel;


+ (UIAlertController*)yu_alertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock;


+ (UIAlertController*)yu_alertControllerWithTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)(void))submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock;

@end
