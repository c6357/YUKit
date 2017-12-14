//
//  NSArray+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YU)

/*
 * Checks to see if the array is empty
 */
@property(nonatomic,readonly,getter=yu_isEmpty) BOOL empty;


-(NSMutableArray*)yu_arrayWithKey:(NSString*)key;

-(NSMutableDictionary*)yu_dictionaryWithKey:(NSString*)key;

-(NSMutableDictionary*)yu_dictionaryWithIntKey:(NSString*)key;

+(id)yu_arrayWithCArray:(char**)strs len:(NSInteger)length;

@end


@interface NSMutableArray(YU)

- (id)yu_firstObject;

- (NSMutableArray *)yu_removeFirstObject;

- (NSMutableArray*)yu_addObject:(id)object,...;

@end
