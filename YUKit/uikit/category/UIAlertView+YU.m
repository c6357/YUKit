//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIAlertView+YU.h"
#import "NSObject+YU.h"

@implementation UIAlertView (YU)

+(void)showMsg:(NSString*)msg{
    
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
}

+(void)ShowInfo:(NSString*)info time:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [alert show];
    alert.backgroundColor = [UIColor blackColor];
    
    [self afterBlock:^{
         [alert dismissWithClickedButtonIndex:0 animated:YES];
    } after:time?time:0.];
}


+(UIAlertView*)ShowConfirmInfo:(NSString*)info delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定" ,nil];
    
    
    alert.delegate = delegate;
    alert.tag = 1000;
    [alert show];
    return alert;
}

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
