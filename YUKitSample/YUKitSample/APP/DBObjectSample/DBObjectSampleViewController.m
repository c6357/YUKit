//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  DBObjectSampleViewController.m
//  YUKit
//
//  Created by BruceYu on 15/12/16.
//  Copyright © 2015年 BruceYu. All rights reserved.
//
//https://github.com/c6357/YUDBObjectSample

#import "DBObjectSampleViewController.h"
#import "UserInfo.h"
#import "DBObj.h"


#define YU_LOG_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ns.log"]

#define YU_NSLog(format, ...)   {fprintf(stderr, "<%s>     line:%d       %s        ",                \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__);                                                       \
(NSLog)((format), ##__VA_ARGS__);                                          \
fprintf(stderr, "");                                              \
}

//#warning 控制台日志
#define openDebugLog 1 //Default 1

/**
 *  DBOBject 使用runtime + fmdb 封装
 
 1.自动建表
 
 2.自动检查增删表字段
 
 3.自定义数据库名，文件路径
 
 4.支持一对一对象数据库存储，清缓存简单方便
 
 5.支持多路径，多数据库关联查询
 
 6.一键保存、修改、删除、查找、多级关联查询解析、反序列化
 
 7.支持数据解析序列化、反序列化、json -> model  and  model ->json
 
 */


@interface DBObjectSampleViewController ()
@end


@implementation DBObjectSampleViewController
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self openConsole];

    [self afterBlock:^{
        [self test];
    } after:0.1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self afterBlock:^{
        [self closeConsole];
//    } after:1];
}



- (void)test{
    
#pragma mark -
#pragma mark - 使用示例
    NSDictionary *baseJson = @{
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
    
    NSMutableArray *list = [NSMutableArray new];
    
    for (int i = 0; i<2000; i++) {
        [list addObject:@{
                          @"name":@"name1",
                          @"phone":@"18500000001",
                          @"age":@(i),
                          @"sex":@(2),
                          }];
    }
    
    NSMutableDictionary *json = [NSMutableDictionary dictionaryWithDictionary:baseJson];
    //    json[@"list"] = list;
    
    
    ///设置数据库路径
    YUDBModel_SetupDBPath([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
    
    ///设置对象归档路径
    YUDBModel_SetupDBPath(NSHomeDirectory());
    
    ///设置数据库版本号
    YUDBModel_SetupDBVersion(@"1.2");
    
    ///删除数据库文件
    YUDBModel_ClearDBFile();
    
    ///开启打印调试日志
    YUDBModel_SetDBLog(YES);
    
    NSLog(@"dbPath: %@",NSObject.dbPath);
    
    NSLog(@"archivePath: %@",NSObject.archivePath);
    
    //-----------------------------------------------------------------------
    //反序列化 把json转换成对象
    //-----------------------------------------------------------------------
    DBObj *dbObj = [DBObj modelWithDictionary:json];
    
    
    //-----------------------------------------------------------------------
    //序列化 把对象转换成json
    //-----------------------------------------------------------------------
    NSLog(@"dictionary %@",[dbObj dictionary]);
    
    
    dbObj.color = [UIColor redColor];
    dbObj.url = [NSURL URLWithString:@"https://github.com/c6357/YUDBModel"];
    dbObj.image = [UIImage imageNamed:@"img"];
    dbObj.number = [NSNumber numberWithFloat:1.5];
    dbObj.data = UIImagePNGRepresentation([UIImage imageNamed:@"img"]);
    
    
    
    //-----------------------------------------------------------------------
    //数据存储 增、删、改、查
    //-----------------------------------------------------------------------
    [NSObject insert:dbObj];
    [NSObject insertObjs:@[dbObj]];
    
    [NSObject save:dbObj];
    [NSObject save:dbObj withKey:@"name"];
    [NSObject save:dbObj withKeys:@[@"name"]];
    [NSObject saveObjs:@[dbObj]];
    
    
    dbObj.countC = 'f';
    [NSObject update:dbObj where:@"name = 'BruceYu'"];
    
    
    [NSObject delete:[dbObj class]];
    [NSObject delete:dbObj WithKey:@"name"];
    
    
    [NSObject insert:dbObj];
    [NSObject insert:dbObj];
    NSArray * arry =  [DBObj query];
    NSLog(@"arry %@",arry);
    
    
    
    
    DBObj *obj = [DBObj queryWithkey:@"name" value:@"BruceYu"];
    obj = [[DBObj query:[DBObj class] where:@"info.infoLevel1.infoLevel2.infoLevel3.infoLevel4.name4 = 'level4'"] firstObject];
    
    if (nil == obj) {
        obj = [[DBObj query:[DBObj class]] firstObject];
    }
    obj.integer = 100;
    obj.name = @"hello";
    [obj update];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageWithData:obj.data];
//    self.view.hidden = NO;
//    [self.view addSubview:imageView];
    
#pragma 对象属性枚举
    NSLog(@"dbObj allKeys %@",[dbObj allKeys]);
    
    NSLog(@"dbObj allValues %@",[dbObj allValues]);
    
    [obj enumerateObjectsKeysAndValues:^(NSString *key, id value, BOOL *stop) {
        NSLog(@"%@ = %@",key,value);
        
    }];
    
    
    
    
    UserInfo *user = [UserInfo newModel];
    user.name = @"BruceYu";
    user.email = @"c6357@outlook.com";
    [UserInfo save:user];
    
    NSLog(@"user %@",[user dictionary]);
    
    //归档
    static NSString *const archiveName = @"DBObj.archive";
    BOOL result = NO;
    if ((result = [NSObject archiveObject:dbObj toName:archiveName])) {
        NSLog(@"归档成功：%@",NSObject.archivePath);
    }
    
    // 解档
    DBObj *person = [NSObject unarchiveObjectWithName:archiveName];
    NSLog(@"解档 DBObj－－－%@",(DBObj*)person.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

