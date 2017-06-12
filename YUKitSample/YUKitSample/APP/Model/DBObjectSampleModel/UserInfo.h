//
//  UserInfo.h
//  https://github.com/c6357/YUDBModel
//
//  Created by BruceYu on 15/8/12.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YUDBModel/YUDBModel.h>


@interface UserInfoLevel6: NSObject

@property (copy, nonatomic, readonly) NSString *name;

@property (copy, nonatomic, readonly) NSString *phone;

@property (copy, nonatomic, readonly) NSString *email;

@property (assign, nonatomic, readonly) int age;

@property (assign, nonatomic, readonly) int sex;

@property (copy, nonatomic, readonly) NSString *name6;

@end


@interface UserInfoLevel5 : NSObject

@property (copy, nonatomic, readonly) NSString *name5;

@property (strong, nonatomic, readonly) UserInfoLevel6 *infoLevel6;

@end


@interface UserInfoLevel4 : NSObject

@property (copy, nonatomic, readonly) NSString *name4;

@property (strong, nonatomic, readonly) UserInfoLevel5 *infoLevel5;

@end

@interface UserInfoLevel3 : NSObject

@property (copy, nonatomic, readonly) NSString *name3;
@property (copy, nonatomic, readonly) NSString *phone3;
@property (strong, nonatomic, readonly) UserInfoLevel4 *infoLevel4;
@end

@interface UserInfoLevel2 : NSObject

@property (copy, nonatomic, readonly) NSString *name2;
@property (copy, nonatomic, readonly) NSString *phone2;

@property (strong, nonatomic, readonly) UserInfoLevel3 *infoLevel3;

@end

@interface UserInfoLevel1 : NSObject

@property (copy, nonatomic, readonly) NSString *name1;

@property (copy, nonatomic, readonly) NSString *phone1;

@property (strong, nonatomic, readonly) UserInfoLevel2 *infoLevel2;

@end



@interface UserInfo : NSObject

@property (copy, nonatomic, readwrite) NSString *name;

@property (copy, nonatomic, readwrite) NSString *phone;

@property (copy, nonatomic, readwrite) NSString *email;

@property (assign, nonatomic, readonly) int age;

@property (assign, nonatomic, readonly) int sex;

@property (strong, nonatomic, readonly) UserInfoLevel1 *infoLevel1 ;

@end
