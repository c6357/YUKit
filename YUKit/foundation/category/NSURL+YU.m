//
//  NSURL+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "NSURL+YU.h"

@implementation NSURL (YU)

- (BOOL) yu_isEqualToURL:(NSURL*)otherURL {
    return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
    ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}


- (NSDictionary *)yu_queryDictionary
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    //将字符串切割成数组
    NSArray *urlParts = [self.absoluteString componentsSeparatedByString:@"?"];
    NSString *paramsString;
    
    if (urlParts.count == 2) {
        paramsString = (NSString *)[urlParts objectAtIndex:1];
    }else{
        paramsString = (NSString *)[urlParts objectAtIndex:0];
    }
    for (NSString *param in [paramsString componentsSeparatedByString:@"&"])
    {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        
        if([elts count] < 2) continue;
        
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    return params;
}

@end
