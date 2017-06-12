//
//  NSNumber+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

//static inline NSString* __intToString(NSInteger num){
//    return num==-1?@"":[NSString stringWithFormat:@"%@",@(num)];
//}

static inline NSString* numberToString(NSUInteger num){
    
    return num==-1?@"":[NSString stringWithFormat:@"%@",@(num)];
    
}


static inline NSString* stringWithFormat(id obj){
    
    return (obj==nil||[obj isEqual:[NSNull null]])?@"":[NSString stringWithFormat:@"%@",obj];
}


@interface NSNumber (YU)

NSNumber*   __INT(NSInteger __x);

NSNumber*   __UINT(NSUInteger __x);

NSNumber*   __FLOAT(float __x);

NSNumber*   __DOUBLE(double __x);

NSNumber*   __BOOL(BOOL __x);


- (NSString*)toString;

@end
