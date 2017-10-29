//
//  UIPasteboard+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 16/1/5.
//  Copyright © 2016年 BruceYu. All rights reserved.
//

#import "UIPasteboard+YU.h"

@implementation UIPasteboard (YU)


+(void)yu_setString:(NSString*)string{
    [self yu_setStrings:@[string]];
}
+(void)yu_setStrings:(NSArray*)strings{
    [[UIPasteboard generalPasteboard] setStrings:strings];
}


+(void)yu_setImage:(UIImage*)image{
    [self yu_setImages:@[image]];
}
+(void)yu_setImages:(NSArray*)images{
    [[UIPasteboard generalPasteboard] setImages:images];
}


+(void)yu_setColor:(UIColor*)color{
    [self yu_setColors:@[color]];
}
+(void)yu_setColors:(NSArray*)colors{
    [[UIPasteboard generalPasteboard] setColors:colors];
}


+(void)yu_setUrl:(NSURL*)url{
    [self yu_setUrls:@[url]];
}
+(void)yu_setUrls:(NSArray*)urls{
    [[UIPasteboard generalPasteboard] setURLs:urls];
}
@end
