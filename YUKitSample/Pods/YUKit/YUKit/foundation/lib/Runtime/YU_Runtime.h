//
//  YU_Runtime.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YURuntime : NSObject

+ (void)swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector ;

@end


