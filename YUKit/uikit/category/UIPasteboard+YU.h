//
//  UIPasteboard+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPasteboard (YU)

+(void)yu_setString:(NSString*)string;
+(void)yu_setStrings:(NSArray*)strings;


+(void)yu_setImage:(UIImage*)image;
+(void)yu_setImages:(NSArray*)images;


+(void)yu_setColor:(UIColor*)color;
+(void)yu_setColors:(NSArray*)colors;

+(void)yu_setUrl:(NSURL*)url;
+(void)yu_setUrls:(NSArray*)urls;

@end
