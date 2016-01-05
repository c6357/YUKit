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
    
    return ^(AFHTTPRequestOperation* response,id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error,Class class) {
            
            _success(success);
            
        }](response,responseObject,nil);
        
    };
}


+ (void (^)())checkHTTPStatusCode :(void(^)(BOOL success,NSError *error))_success{
    
    return ^(AFHTTPRequestOperation* response,id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error,Class class) {
            
            _success(success,error);
            
        }](response,responseObject,nil);
        
    };
}


+ (void (^)())checkHTTPStatusCodeWithModel :(void(^)(BOOL success,NSError *error,id model))success{
    
    return ^(AFHTTPRequestOperation* response,id responseObject,Class class) {
        NSError *error;
        
        NSInteger statusCode = response.response.statusCode;
        NSLog(@"URL-->%@",response.response.URL.absoluteString);
        NSLog(@"statusCode-->%@",@(statusCode));
        NSLog(@"result-->%@",responseObject);
        NSLog(@"response.responseString-->%@",response.responseString);
        //服务返回参数的方式五花八门 so不能轻易断言
        //        NSParameterAssert(response);
        //        NSParameterAssert(responseObject);
        
        if(class){
            NSParameterAssert([class  isSubclassOfClass:[DBObject class]]);
        }
        
        id returnModel = nil;
        /**
         *  成功 解析数据
         */
        if (statusCode == 200) {
            NSDictionary *responseDic = responseObject;
            if (!responseDic) {
                responseDic = (NSDictionary*)response.responseString;
                if ([responseDic isKindOfClass:[NSString class]]) {
                    responseDic = [response.responseString jsonDictionary];
                }
            }
        
            if (responseDic) {
                if ([responseDic isKindOfClass:[NSDictionary class]]) {
                    if (class) {
                        DBObject* model = [[class alloc] init];
                        [model Deserialize:responseDic];
                        returnModel = model;
                    }else{
                        returnModel = responseDic;
                    }
                    
                }else if ([responseDic isKindOfClass:[NSArray class]]){
                    NSMutableArray *arry = [NSMutableArray new];
                    if (class) {
                        for (id obj in responseDic) {
                            DBObject* model = [[class alloc] init];
                            [model Deserialize:obj];
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
            }](response,error);

        }else{
            NSLog(@"Warning：未知statusCode: %@未处理",@(statusCode));
        }
    };
}


+ (void (^)())checkHTTPErrorStatusCode :(void(^)(NSError *error))success{
    
    return ^(AFHTTPRequestOperation* response, NSError *error) {
        
        NSInteger errorCode = response.response.statusCode;
        NSString *msg;
        
        NSLog(@"URL-->%@",response.response.URL.absoluteString);
        NSLog(@"statusCode-->%@",@(errorCode));
        NSLog(@"response-->%@",response.responseString);
        
        NSDictionary *messageDic = (NSDictionary*)response.responseString;
        if (![messageDic isKindOfClass:[NSDictionary class]]) {
            messageDic = [(NSString*)response.responseString jsonDictionary];
        }
        
        if ([messageDic isKindOfClass:[NSDictionary class]]) {
            if (messageDic[@"errorCode"]) {
                errorCode = [messageDic[@"errorCode"] integerValue];
            }
            if(IsSafeStringPlus(TrToString(messageDic[@"message"]))){
                msg = messageDic[@"message"];
            }else{
                msg = HttpCodesDic()[L2S(errorCode)];
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
                if (IsSafeStringPlus(msg)) {
                    [UIAlertView ShowInfo:msg time:1];
                }
            }
            break;
        }
    };
}

@end
