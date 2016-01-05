//
//  UITextField+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UITextField+YU.h"
#import <objc/runtime.h>

@implementation UITextField (YU)

#define mark - disablePaste
static char kDisablePaste;
- (BOOL)isDisablePaste
{
    return [(NSNumber*)objc_getAssociatedObject(self, &kDisablePaste) boolValue];
}

-(void)disablePaste
{
    objc_setAssociatedObject(self, &kDisablePaste, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([self.text length]>0) {
        if (action == @selector(selectAll:) ||action ==@selector(select:) || action == @selector(copy:) || action == @selector(paste:)){
            return [super canPerformAction:action withSender:sender];
        }
    }
    if (action == @selector(paste:) ) {
        return [super canPerformAction:action withSender:sender];
    }
    return NO;
}

@end
