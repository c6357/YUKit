//
//  YU_HTTPRequestOperationManager.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "YU_HTTPRequestOperationManager.h"

NSString * const RelativePathTransformerName = @"RelativePathTransformerName";
@interface YUHTTPRequestOperationManager()
@end

static dispatch_once_t onceToken;
static YUHTTPRequestOperationManager *sharedManagerOfMyserver = nil;
@implementation YUHTTPRequestOperationManager

+ (instancetype)sharedManagerOfServer
{
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:API_SERVER_PATH];
        sharedManagerOfMyserver = [[self alloc] initWithBaseURL:url];
        [sharedManagerOfMyserver setupJsonRequestManager:API_SERVER_PATH];
    });
    return sharedManagerOfMyserver;
}

+(void)resetManagerOfServer{
    YUHTTPRequestOperationManager *instance = [YUHTTPRequestOperationManager sharedManagerOfServer];
    onceToken = 0;
    instance = nil;
    sharedManagerOfMyserver = nil;
}

- (void)setupJsonRequestManager:(NSString *)basePath
{
    // set the request serializer to rc serializer
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // add the aceptable content types
    NSMutableSet *newSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [newSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    
    self.responseSerializer.acceptableContentTypes = newSet;
    
    [self setupValueTransformer:basePath];
}

- (void)setupHttpRequestManager:(NSString *)basePath
{
    // set the request serializer to rc serializer
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    // set the response serializer to json serializer
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    // add the aceptable content types
    NSMutableSet *newSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [newSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    
    self.responseSerializer.acceptableContentTypes = newSet;
    
    [self setupValueTransformer:basePath];
}


- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = self.responseSerializer;
//    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
//    operation.credential = self.credential;
//    operation.securityPolicy = self.securityPolicy;
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
//
//        //在这里可以重复性的处理 参数解析
//        success(operation, responseDict);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        // update the new time stamp
//        failure(operation, error);
//
//    }];
//
//    return operation;
}

// setup the value transformer
// NSURL 与 NSString 互相转换
#warning NSValueTransformer
- (void)setupValueTransformer:(NSString *)basePath
{
//        MTLValueTransformer *relativePathTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSURL *(NSString *relativePath) {
//            NSURL *baseURL = [NSURL URLWithString:basePath];
//            return [NSURL URLWithString:relativePath relativeToURL:baseURL];
//        } reverseBlock:^NSString *(NSURL *url) {
//            return url.relativePath;
//        }];
//    
//        [NSValueTransformer setValueTransformer:relativePathTransformer forName:RelativePathTransformerName];
}

@end
