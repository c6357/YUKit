//
//  DBObj.h
//  YUDBObject
//
//  Created by BruceYu on 15/8/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import <YUDBFramework/DBOBject.h>
#import "UserInfo.h"


@interface DBObj : DBObject

YU_STATEMENT_Strong NSString *name;

YU_STATEMENT_Strong NSString *phone;

YU_STATEMENT_Strong UserInfo *info;

YU_STATEMENT_Strong NSArray *infoArry;

@end
