//
//  ListModel.h
//  YUKitSample
//
//  Created by BruceYu on 16/1/12.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import <YUDBFramework/DBObject.h>

@interface ListModel : DBObject
@property (assign, nonatomic, readonly) long listId;
@property (copy, nonatomic, readonly) NSString *title;
@end
