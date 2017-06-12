//
//  YU_Service.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YU_HTTPRequestOperationManager.h"

#define SAFE_BLOCK_CALL(b,p)        (b==nil?:b(p))
#define SAFE_BLOCK_CALL_VOID(b)     (b==nil?:b())


static NSString * const IOS_SECRET_KEY = @"XXXX";
static NSString * const IOS_CLIENT_NO = @"XXXX";


@interface YUService : NSObject
/**
 *  请求参数类型
 *
 *  @param _success request result
 */
+ (void (^)())checkHTTPStatusCodeRequestSucceed:(void(^)(BOOL success))_success;


/**
 *  无返回参数类型 。错误处理
 *
 *  @param success request result
 */
+ (void (^)())checkHTTPStatusCode:(void(^)(BOOL success,NSError *error))success;


/**
 *请求结果（错误处理 解析数据）
 *
 *  @param success request result
 */
+ (void (^)())checkHTTPStatusCodeWithModel:(void(^)(BOOL success,NSError *error,id model))success;



//错误处理
+ (void (^)())checkHTTPErrorStatusCode :(void(^)(NSError *error))success;

@end
