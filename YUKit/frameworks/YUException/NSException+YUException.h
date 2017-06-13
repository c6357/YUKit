//
//  NSException+YYUException.h
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __OPTIMIZE__
#define YUExceptionProduction  1 //__OPTIMIZE__
#else
#define YUExceptionProduction  1
#endif


@interface NSException (YUException)

+(void)install;


+(void)unknownException:(void(^)(NSException *unknownException, BOOL*dismissed))unknownException;

@end




@interface NSException (exception)

-(void)exception:(void(^)(id obj))obj;

@end




@interface NSObject (runtime)

+ (void)swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end
