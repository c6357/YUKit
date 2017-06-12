//
//  NSNull+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSNull+YU.h"

//原文资料
//http://www.cocoachina.com/industry/20140424/8225.html

#define NSNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (YU)
//方法签名
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    
    if (signature != nil) return signature;
    
    for (NSObject *object in NSNullObjects)
    {
        signature = [object methodSignatureForSelector:selector];
        
        if (signature) break;
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    for (NSObject *object in NSNullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            
            return;
        }
    }
    [self doesNotRecognizeSelector:anInvocation.selector];
}
@end
