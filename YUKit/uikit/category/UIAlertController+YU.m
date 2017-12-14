//
//  UIViewController+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/9.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIAlertController+YU.h"
#import "YUKit.h"

@implementation UIAlertController (YU)
@dynamic yu_titleLabel;
@dynamic yu_messageLabel;

- (NSArray *)yu_viewArray:(UIView *)root {
    static NSArray *_subviews = nil;
    _subviews = nil;
    for (UIView *v in root.subviews) {
        if (_subviews) {
            break;
        }
        if ([v isKindOfClass:[UILabel class]]) {
            _subviews = root.subviews;
            return _subviews;
        }
        [self yu_viewArray:v];
    }
    return _subviews;
}

- (UILabel *)yu_titleLabel {
    return [self yu_viewArray:self.view][0];
}

- (UILabel *)yu_messageLabel {
    return [self yu_viewArray:self.view][1];
}


+(void)yu_showAlertGlobally:(UIAlertController*)alert{
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.windowLevel = UIWindowLevelAlert;
    alertWindow.rootViewController = [UIViewController new];
    [alertWindow makeKeyAndVisible];
    [alertWindow.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


+ (UIAlertController*)yu_alertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    [alert addAction:OKAction];
    
    [self yu_showAlertGlobally:alert];
    
    return alert;
}


+ (UIAlertController*)yu_alertControllerWithTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)(void))submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert ];
    
    if (yu_isSafeString(cancelTitle)) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alert addAction:cancelAction];
    }
    
    if (yu_isSafeString(submitTitle)) {
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (submitBlock) {
                submitBlock();
            }
        }];
        [alert addAction:OKAction];
    }
    
    [self yu_showAlertGlobally:alert];
    
    return alert;
}
@end
