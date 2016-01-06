//
//  NSString+Json.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 14-8-19.
//  Copyright (c) 2014年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)

- (NSDictionary *)jsonDictionary;

- (NSArray *)jsonArray;

@end
