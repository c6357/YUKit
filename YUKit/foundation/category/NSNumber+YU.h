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

static inline NSString* YU_NumberToString(NSUInteger num){
    
    return num==-1?@"":[NSString stringWithFormat:@"%@",@(num)];
    
}


static inline NSString* YU_StringWithFormat(id obj){
    
    return (obj==nil||[obj isEqual:[NSNull null]])?@"":[NSString stringWithFormat:@"%@",obj];
}


@interface NSNumber (YU)

NSNumber*   YU_INT(NSInteger __x);

NSNumber*   YU_UINT(NSUInteger __x);

NSNumber*   YU_FLOAT(float __x);

NSNumber*   YU_DOUBLE(double __x);

NSNumber*   YU_BOOL(BOOL __x);


-(NSString*)yu_toString;

@end
