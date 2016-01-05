//
//  NSString+YUJSON.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "NSString+YUJSON.h"

@implementation NSString (YUJSON)

- (NSDictionary *)jsonDictionary
{
    return [self jsonValue];
}

- (NSArray *)jsonArray
{
    return [self jsonValue];
}

- (id)jsonValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
