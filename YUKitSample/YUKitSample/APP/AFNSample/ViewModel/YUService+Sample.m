//
//  YUService+Sample.m
//  YUKit
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "YUService+Sample.h"
#import "NSDate+YU.h"
#import "NSString+YU.h"

@implementation YUService (Sample)
+ (void)login:(NSDictionary*)info success:(void (^)(UserModel *user))successBlock failure:(NillBlock_Error)failureBlock
{
    [[YUHTTPRequestOperationManager sharedManagerOfServer] POST:@"employee/login.json" parameters:info success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error, id model) {
            
            success?SAFE_BLOCK_CALL(successBlock, model):SAFE_BLOCK_CALL(failureBlock, error);
            
        }](operation,responseObject,[UserModel class]);
        
    } failure:[self checkHTTPErrorStatusCode:^(NSError *error) {
        
        SAFE_BLOCK_CALL(failureBlock, error);
        
    }]];
}


+ (void)GetSampleList:(void (^)(NSArray *List))successBlock failure:(NillBlock_Error)failureBlock{
    
    //测试数据
#ifndef testData
    //sample json data
    NSMutableArray *list = [NSMutableArray new];
    for (int i=0; i<20; i++) {
        [list addObject:@{@"listId":[NSString uuid],
                          @"title":ComboString(@"测试数据%@",[NSDate currentDate:@"HH:mm.ss"]),
                          }];
    }
    //json 转 model
    NSMutableArray *responseObject = [NSMutableArray new];
    for (NSDictionary *info in list) {
        ListModel *data = [[ListModel alloc] init];
        [data Deserialize:info];
        [responseObject addObject:data];
    }
    successBlock(responseObject);
    
#else
    [[YUHTTPRequestOperationManager sharedManagerOfServer] POST:@"Sample/Sample.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self checkHTTPStatusCodeWithModel:^(BOOL success, NSError *error, id model) {
            
            success?SAFE_BLOCK_CALL(successBlock, model):SAFE_BLOCK_CALL(failureBlock, error);
            
        }](operation,responseObject[@"list"],[ListModel class]);
        
    } failure:[self checkHTTPErrorStatusCode:^(NSError *error) {
        
        SAFE_BLOCK_CALL(failureBlock, error);
        
    }]];
#endif
    
}
@end

