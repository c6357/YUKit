//
//  NSError+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSError (YU)

+ (NSError *)errorWithMsg:(NSString *)msg;
+ (NSError *)errorWithMsg:(NSString*)msg obj:(id)obj;



+ (NSError *)errorWithCode:(int)code;
+ (NSError *)errorWithCode:(NSString*)code msg:(NSString*)msg;
+ (NSError *)errorWithCode:(NSString*)code msg:(NSString*)msg obj:(id)obj;

@end
