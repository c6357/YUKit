//
//  YU_HTTPRequestOperationManager.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG

    static NSString *const API_SERVER_PATH = @"http://192.168.0.16:5757/v1";

#else

    static NSString *const API_SERVER_PATH = @"http://192.168.0.16:5757/v1

#endif


// The name for a value transform that converts image relative path string into URLs and back.
extern NSString * const RelativePathTransformerName;

@interface YUHTTPRequestOperationManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManagerOfServer;

+(void)resetManagerOfServer;

@end
