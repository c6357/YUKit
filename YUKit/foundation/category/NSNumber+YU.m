//
//  NSNumber+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSNumber+YU.h"

@implementation NSNumber (YU)

NSNumber*   YU_INT(NSInteger __x){
    return [NSNumber numberWithInteger:__x];
}

NSNumber*   YU_UINT(NSUInteger __x){
    return [NSNumber numberWithUnsignedInteger:__x];
}

NSNumber*   YU_FLOAT(float __x){
    return [NSNumber numberWithFloat:__x];
}

NSNumber*   YU_DOUBLE(double __x){
    return [NSNumber numberWithDouble:__x];
}

NSNumber*  YU_BOOL(BOOL __x){
    return [NSNumber numberWithBool:__x];
}

-(NSString*)yu_toString{
    return [NSString stringWithFormat:@"%@",self];
}

@end
