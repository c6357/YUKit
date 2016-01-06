//
//  NSObject+Json.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 14-8-19.
//  Copyright (c) 2014年 BruceYu. All rights reserved.
//

#import "NSObject+Json.h"


@implementation NSObject (Json)

- (NSString *)HMEJSONString
{
    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
//    
    
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    

    NSError *__autoreleasing error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    NSLog(@"result  1 %@",result);
    if (error != nil) return nil;
    
    NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonStr  3 %@",jsonStr);
    
    
    return jsonStr;
}

@end
