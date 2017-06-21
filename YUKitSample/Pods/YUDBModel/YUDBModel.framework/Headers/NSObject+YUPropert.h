//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  NSObject+YUPropert.h
//  https://github.com/c6357/YUDBModel
//
//  Created by BruceYu on 15/8/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark -
#pragma mark - 属性遍历

@interface NSObject (YUPropert)

///对象的所有属性
@property (nonatomic, copy, readonly) NSArray *allKeys;

///对象的所有属性值
@property (nonatomic, copy, readonly) NSArray *allValues;


/**
 遍历对象的属性名
 
 @param block block description
 */
- (void)enumerateObjectsKeys:(void (NS_NOESCAPE ^)(NSString *key,BOOL *stop))block;


/**
 遍历类的属性名

 @param block block description
 */
+ (void)enumerateObjectsKeys:(void (NS_NOESCAPE ^)(NSString *key,BOOL *stop))block;


/**
 遍历对象的属性名和属性值

 @param block block description
 */
- (void)enumerateObjectsKeysAndValues:(void (NS_NOESCAPE ^)(NSString *key,id value,BOOL *stop))block;


@end
