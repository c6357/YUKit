//
//  NSObject+YUJSON.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject (YUJSON)

#pragma mark -
#pragma mark - NSObject
- (NSString *)yu_jsonString;


#pragma mark -
#pragma mark - NSString
- (NSDictionary *)yu_jsonDictionary;

- (NSArray *)yu_jsonArray;

@end
