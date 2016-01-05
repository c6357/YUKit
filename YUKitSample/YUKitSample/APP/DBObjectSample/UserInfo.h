//
//  UserInfo.h
//  YUDBObject
//
//  Created by BruceYu on 15/8/12.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : DBObject 

YU_STATEMENT_Strong NSString *name;

YU_STATEMENT_Strong NSString *phone;

YU_STATEMENT_Assign int age;

YU_STATEMENT_Assign int sex;

@end
