//
//  UIPasteboard+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import "UIPasteboard+YU.h"

@implementation UIPasteboard (YU)


+(void)setString:(NSString*)string{
    [self setStrings:@[string]];
}
+(void)setStrings:(NSArray*)strings{
    [[UIPasteboard generalPasteboard] setStrings:strings];
}


+(void)setImage:(UIImage*)image{
    [self setImages:@[image]];
}
+(void)setImages:(NSArray*)images{
    [[UIPasteboard generalPasteboard] setImages:images];
}


+(void)setColor:(UIColor*)color{
    [self setColors:@[color]];
}
+(void)setColors:(NSArray*)colors{
    [[UIPasteboard generalPasteboard] setColors:colors];
}


+(void)setUrl:(NSURL*)url{
    [self setUrls:@[url]];
}
+(void)setUrls:(NSArray*)urls{
    [[UIPasteboard generalPasteboard] setURLs:urls];
}
@end
