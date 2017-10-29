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

+(void)yu_showMsg:(NSString*)msg{
    
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
}

+(void)yu_showInfo:(NSString*)title time:(CGFloat)time
{
    #ifndef TARGET_IS_EXTENSION
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [alert show];
    alert.backgroundColor = [UIColor blackColor];
    
    [self yu_afterBlock:^{
         [alert dismissWithClickedButtonIndex:0 animated:YES];
    } after:time?time:0.];
    #endif
}


+(UIAlertView*)yu_showConfirmInfo:(NSString*)title delegate:(id)delegate
{
    #ifndef TARGET_IS_EXTENSION
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定" ,nil];
    
    
    alert.delegate = delegate;
    alert.tag = 1000;
    [alert show];
    return alert;
    #endif
}
@end
