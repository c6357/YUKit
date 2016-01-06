//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  DBObject.h
//  YUDBObject
//
//  Created by BruceYu on 15/8/12.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

/* Database operations DBObject use:*/
/* .Inherited DBObject class*/


/*
 *  Support multiple data using FALASE OR TRUE
 
 *  Set TRUE customizable dbFolder () and dbName (), custom database location and file name
 
 *  Folder Path
 +(NSString*)dbFolder;
 *
 *  Database name
 +(NSString*)dbName;
 */


#import <Foundation/Foundation.h>
#import "NSObject+DB.h"
#import "DBBaseObject.h"


@interface DBObject : DBBaseObject

/**
 *  Data creation time
 */
YU_STATEMENT_Strong NSString *createDate;

/**
 *  Unique identifier ID, Warning: Do not modify and ignored
 */
YU_STATEMENT_Strong NSString *dId;

/**
 *  Associated with the parent ID, used to query
 */
YU_STATEMENT_Strong NSString *parentId;


/**
 *  Folder Path
 *
 *  @return Default Sandbox project folder name
 */
+(NSString*)dbFolder;



/**
 *  Database name
 *
 *  @return Default bundleName
 */
+(NSString*)dbName;


/**
 *  Model to save data, set the fields you want to ignore
 *
 *  @return <#return value description#>
 */
+(NSArray *)dbIgnoreFields;

/*
 */
//-(void)copyTo:(NSObject*)dest;


/**
 *  Deserialize json -> Class
 *
 *  @param _dict <#_dict description#>
 */
-(void)Deserialize:(NSDictionary*)_dict;

-(void)Deserialize:(NSDictionary*)_dict arrayParserObj:(DB_Block_ParserForArray)_parser;

-(void)Deserialize:(NSDictionary*)_dict coustom:(DB_Block_Dealize_Parser)_custParser;

-(void)Deserialize:(NSDictionary *)_dict
    arrayObjParser:(DB_Block_ParserForArray)_parser
arrayObjCustParser:(DB_Block_Dealize_Parser)_custParser;

/**
 *  Deserialize DB data
 *
 *  @param reslut <#reslut description#>
 */
-(void)DeserializeFromDBResult:(FMResultSet*)reslut;

/**
 *  Serialize Class -> json (depth Analytical Model)
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)dictory;

/**
 *  Serialize Class -> json (shallow Analytical Model)
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)dictoryProperties;


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


/**
 *  Get all the data into the table
 *
 *  @return <#return value description#>
 */
+(NSArray*)getAll;

/**
 *  Remove all
 */
+(void)deleteAll;

/**
 *  Delete with keyName
 *
 *  @param keyName <#keyName description#>
 */
-(void)deleteWithKey:(NSString*)keyName;


/**
 *  Delete with keyNames
 *
 *  @param keyNames <#keyNames description#>
 */
-(void)deleteWtihConstraints:(NSArray*)keyNames;


/**
 *  Save with keyName
 *
 *  @param keyName <#keyName description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)save:(NSString*)keyName;


/**
 *  Save with keyNames
 *
 *  @param keyNames <#keyNames description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)saveWtihConstraints:(NSArray*)keyNames;

@end

