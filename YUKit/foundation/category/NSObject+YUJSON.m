//
//  NSObject+YUJSON.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSObject+YUJSON.h"
#import "YUKit.h"

@implementation NSObject (YUJSON)

#pragma mark -
#pragma mark - NSObject
- (NSString *)yu_jsonString
{
    NSError *__autoreleasing error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:self
                                                     options:kNilOptions error:&error];
//    NSLog(@"result  1 %@",result);
    if (error != nil) return nil;
    
    NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
//    NSLog(@"jsonStr  3 %@",jsonStr);
    
    return YU_SafeString(jsonStr);
}


#pragma mark -
#pragma mark - NSString
- (NSDictionary *)yu_jsonDictionary
{
    return [self yu_jsonValue];
}

- (NSArray *)yu_jsonArray
{
    return [self yu_jsonValue];
}

- (id)yu_jsonValue
{
    if (![self isKindOfClass:[NSString class]]) {
//        NSLog(@"%@：%@",self,self.class);
        return nil;
    }
    
    NSData *data = [(NSString*)self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
