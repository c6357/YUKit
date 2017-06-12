//
//  YU_Service.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "YU_Service.h"

//Custom sample
typedef enum : NSUInteger {
    HTTPStatusCode_200 = 200,
    HTTPStatusCode_400 = 400,
    HTTPStatusCode_401 = 401,
    HTTPStatusCode_500 = 500,
    HTTPStatusCode_601 = 601,
    HTTPStatusCode_602 = 602,
    HTTPStatusCode_603 = 603,
    HTTPStatusCode_610 = 610,
    HTTPStatusCode_611 = 611,
    HTTPStatusCode_612 = 612,
} HTTPStatusCode;

//Custom sample
static inline NSDictionary *HttpCodesDic(){
    return@{
            @"200":@"成功",
            @"400":@"错误请求(缺少参数,或者参数类型不符合条件,具体原因看返回内容)",
            @"401":@"未授权,需要重新登录,(非法或者过期的accessToken)",
            @"500":@"服务异常",
            @"601":@"XXXXXX",
            @"602":@"XXXXXX",
            @"603":@"XXXXXX",
            @"610":@"XXXXXX",
            @"611":@"XXXXXX",
            @"612":@"XXXXXX",
            };
}

@implementation YUService
+ (void (^)())checkHTTPStatusCodeRequestSucceed :(void(^)(BOOL success))_success{
    
    return ^(NSURLSessionDataTask* task,id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error,Class class) {
            
            _success(success);
            
        }](task,responseObject,nil);
        
    };
}


+ (void (^)())checkHTTPStatusCode :(void(^)(BOOL success,NSError *error))_success{
    
    return ^(NSURLSessionDataTask* task,id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error,Class class) {
            
            _success(success,error);
            
        }](task,responseObject,nil);
        
    };
}


+ (void (^)())checkHTTPStatusCodeWithModel :(void(^)(BOOL success,NSError *error,id model))success{
    
    return ^(NSURLSessionDataTask* task,id responseObject,Class class) {
        NSError *error;
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
        NSInteger statusCode = [httpResponse statusCode];
        
    
        NSLog(@"URL-->%@",task.response.URL.absoluteString);
        NSLog(@"statusCode-->%@",@(statusCode));
        //        NSLog(@"response-->%@",httpResponse.);

        
//        if(class){
//            NSParameterAssert([class  isSubclassOfClass:[DBObject class]]);
//        }
        
        id returnModel = nil;
        /**
         *  成功 解析数据
         */
        if (statusCode == 200) {
            NSDictionary *responseDic = responseObject;
            if (!responseDic) {
                responseDic = (NSDictionary*)task.response.URL.absoluteString;
                if ([responseDic isKindOfClass:[NSString class]]) {
                    responseDic = [task.response.URL.absoluteString jsonDictionary];
                }
            }
        
            if (responseDic) {
                if ([responseDic isKindOfClass:[NSDictionary class]]) {
                    if (class) {
                        NSObject* model = [[class alloc] init];
                        [model deserialize:responseDic];
                        returnModel = model;
                    }else{
                        returnModel = responseDic;
                    }
                    
                }else if ([responseDic isKindOfClass:[NSArray class]]){
                    NSMutableArray *arry = [NSMutableArray new];
                    if (class) {
                        for (id obj in responseDic) {
                            NSObject* model = [[class alloc] init];
                            [model deserialize:obj];
                            [arry addObject:model];
                        }
                    }else{
                        NSLog(@"Warning：有未知类型\n%@\n没有解析",responseDic);
                    }
                    returnModel = arry;
                    
                }else if ([responseDic isKindOfClass:[NSString class]]){
                    returnModel = responseDic;
                    NSLog(@"responseDic %@",responseDic);
                }
                
            }else{
                NSLog(@"Warning：没有返回参数");
            }
            success(true,error,returnModel);
            
        /**
         *  失败 解析错误提示 例如：这里202
         */
        }else if(statusCode == 202){
            
            [self checkHTTPErrorStatusCode:^(NSError *error) {
                success(false,error,returnModel);
            }](task,error);

        }else{
            NSLog(@"Warning：未知statusCode: %@未处理",@(statusCode));
        }
    };
}


+ (void (^)())checkHTTPErrorStatusCode :(void(^)(NSError *error))success{
    
    return ^(NSURLSessionDataTask* task, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
        NSInteger errorCode = [httpResponse statusCode];
        
        NSString *msg;
        
        NSLog(@"URL-->%@",task.response.URL.absoluteString);
        NSLog(@"statusCode-->%@",@(errorCode));
//        NSLog(@"response-->%@",httpResponse.);
        
        NSDictionary *messageDic = (NSDictionary*)task.response.URL.absoluteString;//httpResponse.allHeaderFields;//(NSDictionary*)response.responseString;
        if (![messageDic isKindOfClass:[NSDictionary class]]) {
            messageDic = [(NSString*)task.response.URL.absoluteString jsonDictionary];
        }
        
        if ([messageDic isKindOfClass:[NSDictionary class]]) {
            if (messageDic[@"errorCode"]) {
                errorCode = [messageDic[@"errorCode"] integerValue];
            }
            if(isSafeString(stringWithFormat(messageDic[@"message"]))){
                msg = messageDic[@"message"];
            }else{
                msg = HttpCodesDic()[@(errorCode)];
            }
        }
       
        switch (errorCode) {
            //程序处理
            case HTTPStatusCode_400:
            {
                NSLog(@"msg：%@",msg);
            }
                break;
                
            //特殊处理 添加此处
            case HTTPStatusCode_401:
            {

            }
                break;
                
            //错误 提示
            default:{
                error = [NSError errorWithCode:[NSString stringWithFormat:@"%@",@(errorCode)] msg:msg];
                success(error);
                if (isSafeString(msg)) {
                    [UIAlertView showInfo:msg time:1];
                }
            }
            break;
        }
    };
}

@end
