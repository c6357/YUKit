//
//  NSNumber+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSNumber+YU.h"

@implementation NSNumber (YU)

NSNumber*   __INT(int __x){
    return [NSNumber numberWithInt:__x];
}

NSNumber*   __UINT(NSUInteger __x){
    return [NSNumber numberWithUnsignedInteger:__x];
}

NSNumber*   __FLOAT(float __x){
    return [NSNumber numberWithFloat:__x];
}

NSNumber*   __DOUBLE(double __x){
    return [NSNumber numberWithDouble:__x];
}

NSNumber*  __BOOL(BOOL __x){
    return [NSNumber numberWithBool:__x];
}

@end
