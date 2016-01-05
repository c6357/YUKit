//
//  UIAlertView+YU.m
//  YUKitSample
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import "UIAlertView+YU.h"

@implementation UIAlertView (YU)

//+ (void)alertView:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
//    [alert bk_setHandler:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }forButtonAtIndex:0];
//    
//    [alert show];
//}
//
//
//+ (void)alertView:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:submitTitle, nil];
//    [alert bk_setHandler:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }forButtonAtIndex:0];
//    
//    [alert bk_setHandler:^{
//        if (submitBlock) {
//            submitBlock();
//        }
//    } forButtonAtIndex:1];
//    [alert show];
//}
@end
