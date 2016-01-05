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
#import <YUDBFramework/DBObject.h>


#define YU_LOG_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ns.log"]

#define YU_NSLog(format, ...)   {fprintf(stderr, "<%s>     line:%d       %s        ",                \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__);                                                       \
(NSLog)((format), ##__VA_ARGS__);                                          \
fprintf(stderr, "");                                              \
}

#warning 控制台日志
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

//    [self afterBlock:^{
        [self dbSample];
//    } after:0.1];
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

-(void)dbSample{
#pragma mark - textView日志显示
#if openDebugLog
        //    int X = arc4random() % 100;
    //    if (X%2 == 1) {
    //        [self showDebug];
    //    }
#endif
    
    
//    usleep(2000000);
    
    UserInfo *user = [[UserInfo alloc] init];
    user.name = @"test";
    user.phone = @"18521911111";
    [user save:@"name"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<15; i++) {
        UserInfo *user = [[UserInfo alloc] init];
        user.name = @"test";
        user.phone = ComboString(@"185219_%@", @(i));
        user.age = 1;
        user.dId = ComboString(@"%@", @(i));
        [arr addObject:user];
    }
    
    DBObj *obj = [[DBObj alloc] init];
    obj.name = @"test1";
    obj.phone = @"123456789";
    obj.info = user;
    obj.infoArry = arr;
    [obj save:@"name"];
    
#if 0
    [DBObj save:obj];
    [obj saveWtihConstraints:@[@"name"]];
    
    [obj deleteWithKey:@"name"];
    
    [obj deleteWtihConstraints:@[@"name"]];
#endif
    
    
#if 0
    NSDictionary *dic = [obj dictory];
    
    DBObj *objj = [[DBObj alloc] init];
    [objj Deserialize:dic];
    NSLog(@"_ms = %@",_ms);
    
    NSArray *userArry = [UserInfo getAll];
    
    NSArray *userArry = [UserInfo getWtihConstraints:@{@"phone":@"185219_1"}];
    
    NSArray *userArry = [UserInfo getList:@"phone" value:@"185219_1"];
    
    DBObj *userArry = [DBObj get:@"name" value:@"test1"];
    NSLog(@"userArry. name %@",userArry.infoArry);
    NSLog(@"info. name %@",userArry.info.phone);
    
    for (UserInfo *info in userArry) {
        
        DBLog(@"info  %@",[info dictory]);
    }
    NSLog(@"1");
#endif
    
    NSArray *userArry = [DBObj getAll];
    for (DBObj *info in userArry) {
        
        DBLog(@"info  %@",[info dictory]);
        
        for (UserInfo *obj in info.infoArry) {
            
            DBLog(@"obj  %@",[obj dictory]);
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

