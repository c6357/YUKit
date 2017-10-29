//
//  NSError+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSError (YU)

+ (NSError *)yu_errorWithMsg:(NSString *)msg;
+ (NSError *)yu_errorWithMsg:(NSString*)msg obj:(id)obj;

+ (NSError *)yu_errorWithCode:(int)code;
+ (NSError *)yu_errorWithCode:(NSString*)code msg:(NSString*)msg;
+ (NSError *)yu_errorWithCode:(NSString*)code msg:(NSString*)msg obj:(id)obj;

@end
