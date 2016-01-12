//
//  UIPasteboard+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPasteboard (YU)

+(void)setString:(NSString*)string;
+(void)setStrings:(NSArray*)strings;


+(void)setImage:(UIImage*)image;
+(void)setImages:(NSArray*)images;


+(void)setColor:(UIColor*)color;
+(void)setColors:(NSArray*)colors;

+(void)setUrl:(NSURL*)url;
+(void)setUrls:(NSArray*)urls;

@end
