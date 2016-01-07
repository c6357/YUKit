//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  NSObject+DB.h
//  YUDBObject
//
//  Created by yuzhx on 15/8/12.
//  Copyright (c) 2015年 C6357. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface NSObject (DB)

/**
 *  table create
 */

+(void)creteTable;

/**
 *  save the model with keyName
 *
 *  @param obj      DBObject subClass
 *  @param keyName  select tableName where keyName = value,Search results, If present, the update, or the inserted
 *
 *  @return Save the result
 */
+(BOOL)save:(id)obj KeyName:(NSString*)keyName;


/**
 *  save the model with keyNames
 *
 *  @param obj      DBObject subClass
 *  @param keyNames keyName collection ,select tableName where keyName = value and keyName = value ...,Search results, If present, the update, or the inserted
 *
 *  @return Save the result
 */
+(BOOL)saveWtihConstraints:(id)obj KeyNames:(NSArray*)keyNames;


/**
 *  save the model
 *
 *  @param obj DBObject subClass
 *
 *  @return Save the result
 */
+(BOOL)save:(id)obj;


/**
 *  save the model
 *
 *  @param objs DBObject subClass collection
 *
 *  @return Save the result
 */
+(BOOL)saveObjs:(NSArray *)objs;



/**
 *  select * from   SELECT * FROM tableName WHERE keyName = value
 *
 *  @param keyName <#keyName description#>
 *  @param value   <#value description#>
 *
 *  @return select the result (DBObject model)
 */
+(id)get:(NSString*)keyName value:(NSString*)value;


/**
 *  select * from   SELECT * FROM class WHERE keyName = value
 *
 *  @param keyName <#keyName description#>
 *  @param value   <#value description#>
 *
 *  @return select the result (DBObject model array)
 */
+(NSArray*)getList:(NSString*)keyName value:(NSString*)value;


/**
 *  select * from   SELECT * FROM class WHERE keyName = value and keyName = value..
 *
 *  @param keyValues <#keyValues description#>
 *
 *  @return select the result (DBObject model array)
 */
+(NSArray*)getWtihConstraints:(NSDictionary*)keyValues;



/**
 *  select * from   SELECT * FROM class WHERE keyName = value and keyName = value..
 *
 *  @param where   <#where description#>
 *  @param groupBy <#groupBy description#>
 *  @param orderBy <#orderBy description#>
 *  @param limit   <#limit description#>
 *
 *  @return select the result (DBObject model array)
 */
+(NSArray *)selectWhere:(NSString *)where groupBy:(NSString *)groupBy orderBy:(NSString *)orderBy limit:(NSString *)limit;


/*
 * Get all the data into the table 
 */
+(NSArray*)getAll;

/*
 *  Remove all
 */
+(void)deleteAll;


@end



@interface NSObject(FMDB)

/*
 *  Analyzing table exists
 */
+(BOOL)checkTableExists;


/*
 *  Check the model operation is safe
 */
+(BOOL)checkModel;


/*
 *  configModel
 */
+(void)configModel;


/**
 *  Create a need to save the file to the Documents directory
 *
 *  @param Directories folder name
 *
 *  @return successfully created folder path
 */
+ (NSString*)createFileDirectories:(NSString*)Directories;

@end

