//
//  YUService+Sample.h
//  YUKit
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//
#import <YUDBFramework/DBObject.h>
#import "YU_Service.h"
#import "YUKit.h"

@class UserModel;
@class ListModel;

@interface YUService (Sample)

//API Sample
+ (void)login:(NSDictionary*)info success:(void (^)(UserModel *user))successBlock failure:(NillBlock_Error)failureBlock;


+ (void)GetSampleList:(void (^)(NSArray *List))successBlock failure:(NillBlock_Error)failureBlock;


@end


//Model Sample
@interface UserModel : DBObject
@property (copy, nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSString *password;
@end


@interface ListModel : DBObject
@property (assign, nonatomic, readonly) long listId;
@property (copy, nonatomic, readonly) NSString *title;
@end