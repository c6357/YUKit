//
//  YUService+Sample.h
//  YUKit
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//
#import "YU_Service.h"
#import "ListModel.h"
#import "UserModel.h"

@interface YUService (Sample)


//API Sample
+ (void)login:(NSDictionary*)info success:(void (^)(UserModel *user))successBlock failure:(NillBlock_Error)failureBlock;


+ (void)GetSampleList:(void (^)(NSArray *List))successBlock failure:(NillBlock_Error)failureBlock;


@end

