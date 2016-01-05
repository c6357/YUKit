//
//  NSString+YUJSON.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YUJSON)

- (NSDictionary *)jsonDictionary;

- (NSArray *)jsonArray;

@end
