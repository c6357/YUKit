//
//  UserModel.h
//  YUKitSample
//
//  Created by BruceYu on 16/1/12.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import <YUDBFramework/DBObject.h>

@interface UserModel : DBObject
@property (copy, nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSString *password;
@end
