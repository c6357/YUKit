//
//  NSNumber+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSNumber (YU)

NSNumber*   __INT(int __x);

NSNumber*   __UINT(NSUInteger __x);

NSNumber*   __FLOAT(float __x);

NSNumber*   __DOUBLE(double __x);

NSNumber*   __BOOL(BOOL __x);

@end
