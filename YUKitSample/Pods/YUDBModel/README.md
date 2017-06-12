YUDBModel
=========
(直接实现json反序列化对象-对象增删改查数据库-对象序列化的插件)
-
[![Travis branch](https://img.shields.io/travis/rust-lang/rust/master.svg)](https://github.com/c6357/YUDBModel)
[![CocoaPods](https://img.shields.io/cocoapods/v/YUDBModel.svg)](https://github.com/c6357/YUDBModel)
[![Travis branch](https://img.shields.io/badge/YUDBModel-绿色插件-brightgreen.svg)](https://github.com/c6357/YUDBModel)

### 一、YUDBModel 介绍
- **架构**: 使用runtime和Sqlite实现NSObject扩展类YUDBModel,直接实现(json反序列化对象-对象增删改查数据库-对象序列化)
- **易用**: 无需继承，直接实现序列化、反序列化、一行代码操作数据库
- **稳定**: 耦合度低，容错率高，兼容复杂和特殊数据类型
- **支持**: (NSObject,NSArray,NSDictionary,NSData,NSString,NSNumber,NSURL,Int,double,long,float,Bool,char)类型
- **灵活**: 支持反序列化json key替换，支持自设定主键，支持忽略模型存储字段，支持反序列化代理之定义数据(deserialize())，支持使用Sqlite函数进行查询.
- **强大**: 支持json反序列化对象-对象增删改查数据库-对象序列化，支持模型嵌套存储和多表嵌套复杂查询
- **智能**: 自动增删改表字段，自动初始化空对象(NSObject,NSArray,NSDictionary,NSString)

### 二、YUDBModel 集成
* 手动复制《YUDBModel.framework》到工程

* 使用Cocoapods管理


### 三、YUDBModel 使用

#### YUDBModel配置
	///设置数据库路径
	extern void YUDBModel_SetupDBPath(NSString *path);
	
	///设置对象归档路径
	extern void YUDBModel_SetupObjectPath(NSString *path);
	
	///设置数据库版本号
	extern void YUDBModel_SetupDBVersion(NSString *version);
	
	///打开日志输出
	extern void YUDBModel_SetDBLog(BOOL on);
	
	///删除数据库文件
	extern BOOL YUDBModel_ClearDBFile();
	
#### 反序列化 

* DBObj class

```
struct User {
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *email;
    int age;
};

@interface BASEDBObj : NSObject
@end

@interface DBObj : BASEDBObj

@property (copy, nonatomic, readonly) NSNumber *objId;

@property (nonatomic, assign, readonly)Point *point;
@property (nonatomic, assign, readonly)struct User *user;
@property (nonatomic, assign, readonly)Method method;
@property (nonatomic, assign, readonly)Ivar ivar;
@property (nonatomic, assign, readonly)Category category;
@property (nonatomic, assign, readonly)objc_property_t property;

@property (copy, nonatomic, readonly) void(^Block)(void);
@property (copy, nonatomic, readwrite) id obj;
@property (copy, nonatomic, readwrite) Class classz;
@property (assign, nonatomic, readwrite) SEL sel;


@property (copy, nonatomic, readwrite) NSString *name;
@property (copy, nonatomic, readonly) UserInfo *info;
@property (copy, nonatomic, readonly) NSArray *list;

@property (copy, nonatomic, readwrite) NSArray *array;
@property (copy, nonatomic, readwrite) NSDictionary *dict;
@property (copy, nonatomic, readwrite) NSData *data;
@property (copy, nonatomic, readwrite) NSDate *date;
@property (copy, nonatomic, readwrite) NSURL *url;
@property (copy, nonatomic, readwrite) NSNumber *number;
@property (copy, nonatomic, readwrite) NSValue *value;


@property (copy, nonatomic, readwrite) UIImage *image;
@property (copy, nonatomic, readwrite) UIColor *color;


@property (assign, nonatomic, readwrite) char countC;
@property (assign, nonatomic, readwrite) unsigned char countUC;
@property (assign, nonatomic, readwrite) short countS;
@property (assign, nonatomic, readwrite) unsigned short countUS;
@property (assign, nonatomic, readwrite) int countI;
@property (assign, nonatomic, readwrite) unsigned int countUI;
@property (assign, nonatomic, readwrite) long countL;
@property (assign, nonatomic, readwrite) unsigned long countUL;
@property (assign, nonatomic, readwrite) long long countLL;
@property (assign, nonatomic, readwrite) unsigned long long countULL;
@property (assign, nonatomic, readwrite) float countF;
@property (assign, nonatomic, readwrite) double countD;
@property (assign, nonatomic, readwrite) BOOL countB;
@property (assign, nonatomic, readwrite) NSInteger integer;
@property (assign, nonatomic, readwrite) NSUInteger uinteger;

@end
```

* json

```
@{
    @"name":@"BruceYu",
    @"id":@"0001",
    @"countF":@"1.6",
    @"countD":@"1.6",
    @"countLL":@"6",
    @"countUL":@"66",
    @"countULL":@"666",
    @"countS":@(100),
    @"countUS":@(99),
    @"countB":@"1",
    @"integer":@"1",
    @"uinteger":@"1",
    @"countC":@'c',
    @"countUC":@'c',
    @"url":@"https://github.com/c6357/YUDBModel",
    @"dict":@{
            @"name":@"(null)",
            @"phone":@"18512345678",
            @"age":@(66),
            @"sex":@(1),
            },

    
    @"info":@{
           @"name":@"bruce",
           @"phone":@"(null)",
           @"age":@(66),
           @"sex":@(1),
           @"infoLevel1" :         @{
               @"infoLevel2" :             @{
                   @"infoLevel3" :                 @{
                       @"infoLevel4" :                     @{
                           @"infoLevel5" :                         @{
                               @"infoLevel6" :                             @{
                                   @"name6" : @"level6",
                               },
                               @"name5" : @"level5",
                           },
                           @"name4" : @"level4",
                       },
                       @"name3" : @"level3",
                   },
                   @"name2" : @"level2",
               },
               @"name1" : @"level1",
               @"phone1" : @"phone1",
               },
           },
    
    @"list":@[
                @{
                    @"name":@"name1",
                    @"phone":@"18500000001",
                    @"age":@(11),
                    @"sex":@(2),
               },
                @{
                    @"name":@"(null)",
                    @"phone":@"18500000002",
                    @"age":@(22),
                    @"sex":@(2),
                    },
                
                @{
                    @"name":@"name3",
                    @"phone":@"18500000003",
                    @"age":@(33),
                    @"sex":@(3),
                    },
           ],
    };
```


```oc
///把json转换成对象	
DBObj *dbObj = [DBObj modelWithDictionary:json];
```
	
```oc
/**
 反序列化JSON需要替换的KEY
 
 @return @{@"mode key":@"json key"}
 */
+(NSDictionary <NSString *, NSString*> *)YUDBModel_ReplacePropertyKey;

/**
 需要过滤在数据库表中的特殊字段 不储存的字段
 
 @return  e.g. return @[@"desrc"]
 */
+(NSArray<NSString*> *)YUDBModel_IgnoreFields;

/**
 设置主键
 
 @return 主键的 keyName
 */
+(NSString*)YUDBModel_PrimaryKey;


/**
 反序列化json自定义操作（通常用于NSArray和特殊处理）
 
 @param key key值
 @param value value值
 @return 根据key和value返回相应的对象
 
 e.g.
 -(void)deserialize:(NSDictionary *)dictionary
 {
	 [super deserialize:dictionary arrayParser:^id(NSString *key,id value) {
	 
		 if ([key isEqualToString:@"list"]) {
		 
			 return [UserInfo class];
		 }
		 
		 else if ([key isEqualToString:@"array"]) {
		 
			 return @[@"1",@"2",@"3"];//自定义数组
		 }
		 
		 else if ([key isEqualToString:@"name"]) {
		 
		 	return @"自定义名字";
		 }
		 
 		return nil;
 		
	 }];
	 
 }
```


#### 序列化
	///把对象转换成json
	NSDictionary * json = [dbObj dictionary];
	
#### 数据存储 增、删、改、查

* 增 改

```oc
///直接插入一条数据
[NSObject insert:dbObj];
	
///直接插入多条数据
[NSObject insertObjs:@[dbObj]];

///保存一条数据（根据rowid查找 if数据存在更新else插入）
[NSObject save:dbObj];

///保存多条数据（根据rowid查找 if数据存在更新else插入）
[NSObject saveObjs:@[dbObj]];

///保存一条数据（根据key值条件查找 if数据存在更新else插入）
[NSObject save:dbObj withKey:@"name"];

///保存一条数据（根据多个key值条件查找 if数据存在更新else插入）
[NSObject save:dbObj withKeys:@[@"name"]];

///更新一条数据（只执行更新语句）
[NSObject update:dbObj where:@"name = 'BruceYu'"];

```

* 删

```oc
///删除表dbObj [obj Class]
[NSObject delete:[dbObj class]];

///根据条件key删除表[object class]数据
[NSObject delete:dbObj WithKey:@"name"];

///根据多个条件key删除表[object class]数据
[NSObject delete:dbObj withKeys:@[@"name"]];

///根据条件删除表[obj Class]数据
[NSObject delete:dbObj where:@"name = 'BruceYu' "];
    
```
	
* 查

```
///举个栗子
DBObj *obj = [DBObj queryWithkey:@"name" value:@"BruceYu"];

if (nil == obj) {
	obj = [[DBObj query:[DBObj class]where:@"info.infoLevel1.infoLevel2.infoLevel3.infoLevel4.name4 = 'level4'"] firstObject];
}

if (nil == obj) {
    obj = [[DBObj query:[DBObj class]] firstObject];
}

obj.integer = 100;
obj.name = @"hello";
[obj update];

```

```oc
#pragma mark - 简单查询
/**
 查询表[self class]所有数据

 @return array
 */
+ (NSArray *)query;

/**
  查询表[obj Class]所有数据

 @param objClass 数据模型
 @return array
 */
+ (NSArray *)query:(Class)objClass;

/**
  查询表[self class]数据

 @param key 查询条件键key
 @param value 查询条件键valus
 @return 符合条件的第一条数据
 */
+ (id)queryWithkey:(NSString*)key value:(NSString*)value;

/**
   查询表[self class]数据

 @param key 查询条件键key
 @param value 查询条件键valus
 @return array
 */
+ (NSArray *)query:(NSString*)key value:(NSString*)value;

/**
    查询表[self class]数据

 @param keyValues 查询条件键的{key:valus}
 @return array
 */
+ (NSArray *)queryWithkeyValues:(NSDictionary*)keyValues;


#pragma mark - 高级查询

/**
 查询表[obj Class]数据

 @param objClass 数据模型
 @param where where条件
 @return array
 */
+ (NSArray *)query:(Class)objClass where:(NSString *)where;


/**
  查询表[obj Class]数据

 @param objClass 数据模型
 @param order order by 条件
 @return array
 */
+ (NSArray *)query:(Class)objClass order:(NSString *)order;


/**
  查询表[obj Class]数据

 @param objClass 数据模型
 @param limit LIMIT 语句
 @return array
 */
+ (NSArray *)query:(Class)objClass limit:(NSString *)limit;


/**
 查询表[obj Class]数据
 
 @param objClass 数据模型
 @param where where条件
 @param order order by
 @return array
 */
+ (NSArray *)query:(Class)objClass where:(NSString *)where order:(NSString *)order;

/**
 查询表[obj Class]数据
 
 @param objClass 数据模型
 @param where where条件
 @param limit limit
 @return array
 */
+ (NSArray *)query:(Class)objClass where:(NSString *)where limit:(NSString *)limit;


/**
 查询表[obj Class]数据
 
 @param objClass 数据模型
 @param order order by
 @param limit limit
 @return array
 */
+ (NSArray *)query:(Class)objClass order:(NSString *)order limit:(NSString *)limit;


/**
 查询表[obj Class]数据

 @param objClass 数据模型
 @param where where条件
 @param order order by
 @param limit limit
 @return array
 */
+ (NSArray *)query:(Class)objClass where:(NSString *)where order:(NSString *)order limit:(NSString *)limit;


#pragma mark - 自助高级查询
/**
  查询数据
 @param objClass 需要反序列化的数据模型objClass
 @param sql 纯sql语句
 @return array @[objClass,objClass,objClass.....]
 */
+ (NSArray *)query:(Class)objClass sql:(NSString *)sql;


/**
 执行一条sql更新语句

 @param sql 纯sql语句
 @return 执行结果
 */
+ (BOOL)executeUpdateWithSql:(NSString *)sql;
    
```
	
* 归档

```oc
 ///存档一个对象
static NSString *const archiveName = @"DBObj.archive";
BOOL result = NO;
if ((result = [NSObject archiveObject:dbObj toName:archiveName])) {
    NSLog(@"归档成功：%@",NSObject.archivePath);
}
   
```

* 解档

```oc
/// 解档一个对象
DBObj *obj = [NSObject unarchiveObjectWithName:archiveName];
NSLog(@"解档 DBObj－－－%@",(DBObj*)obj.name);
```

* 更多请查阅API