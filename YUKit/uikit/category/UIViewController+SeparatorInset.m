//
//  UIViewController+SeparatorInset.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIViewController+SeparatorInset.h"
#import <objc/runtime.h>

static NSString *ES_INSETS_ASS_KEY = @"ES_INSETS_ASS_KEY";

@interface UIViewController()

@property (nonatomic, assign) UIEdgeInsets inset;

@end

@implementation UIViewController (SeparatorInset)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(tableView:willDisplayCell:forRowAtIndexPath:);
        SEL swizzledSelector = @selector(yu_tableView:willDisplayCell:forRowAtIndexPath:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)yu_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self yu_setSeparatorInsetWithTarget:cell insets:self.inset];
    
    if ([self respondsToSelector:@selector(yu_tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self yu_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)yu_setSeparatorInsetZeroWithTableView:(UITableView *)tableView{
    [self yu_setSeparatorInsetWithTableView:tableView inset:UIEdgeInsetsZero];
}

- (void)yu_setSeparatorInsetWithTableView:(UITableView *)tableView inset:(UIEdgeInsets)inset{
    self.inset = inset;
    [self yu_setSeparatorInsetWithTarget:tableView insets:inset];
}

- (void)yu_setSeparatorInsetWithTarget:(id)target insets:(UIEdgeInsets)insets{
    if ([target respondsToSelector:@selector(setSeparatorInset:)]) {
        [target setSeparatorInset:insets];
    }
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:insets];
    }
}

- (void)setInset:(UIEdgeInsets)insets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:insets];
    objc_setAssociatedObject(self, &ES_INSETS_ASS_KEY, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)inset{
    NSValue *value = objc_getAssociatedObject(self, &ES_INSETS_ASS_KEY);
    return [value UIEdgeInsetsValue];
}
@end
