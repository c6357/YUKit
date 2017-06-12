//
//  DBObj.h
//  https://github.com/c6357/YUDBModel
//
//  Created by BruceYu on 15/8/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import <YUDBModel/YUDBModel.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UserInfo.h"


struct User {
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *email;
    int age;
};

@interface DBObj : NSObject

@property (copy, nonatomic, readonly) NSNumber *objId;

@property (nonatomic, assign, readonly)Point *point;
@property (nonatomic, assign, readonly)struct User *user;
@property (nonatomic, assign, readonly)Method method;
@property (nonatomic, assign, readonly)Ivar ivar;
@property (nonatomic, assign, readonly)Category category;
@property (nonatomic, assign, readonly)objc_property_t property;

@property (copy, nonatomic, readonly) void(^Block)(void);
@property (copy, nonatomic, readwrite) id obj;
@property (copy, nonatomic, readwrite) Class classz;
@property (assign, nonatomic, readwrite) SEL sel;


@property (copy, nonatomic, readwrite) NSString *name;
@property (copy, nonatomic, readonly) UserInfo *info;
@property (copy, nonatomic, readonly) NSArray *list;

@property (copy, nonatomic, readwrite) NSArray *array;
@property (copy, nonatomic, readwrite) NSDictionary *dict;
@property (copy, nonatomic, readwrite) NSData *data;
@property (copy, nonatomic, readwrite) NSDate *date;
@property (copy, nonatomic, readwrite) NSURL *url;
@property (copy, nonatomic, readwrite) NSNumber *number;
@property (copy, nonatomic, readwrite) NSValue *value;


@property (copy, nonatomic, readwrite) UIImage *image;
@property (copy, nonatomic, readwrite) UIColor *color;


@property (assign, nonatomic, readwrite) char countC;
@property (assign, nonatomic, readwrite) unsigned char countUC;
@property (assign, nonatomic, readwrite) short countS;
@property (assign, nonatomic, readwrite) unsigned short countUS;
@property (assign, nonatomic, readwrite) int countI;
@property (assign, nonatomic, readwrite) unsigned int countUI;
@property (assign, nonatomic, readwrite) long countL;
@property (assign, nonatomic, readwrite) unsigned long countUL;
@property (assign, nonatomic, readwrite) long long countLL;
@property (assign, nonatomic, readwrite) unsigned long long countULL;
@property (assign, nonatomic, readwrite) float countF;
@property (assign, nonatomic, readwrite) double countD;
@property (assign, nonatomic, readwrite) BOOL countB;
@property (assign, nonatomic, readwrite) NSInteger integer;
@property (assign, nonatomic, readwrite) NSUInteger uinteger;

@end
