//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  RuntimeSampleViewController.m
//  YUKit
//
//  Created by BruceYu on 15/12/30.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "RuntimeSampleViewController.h"
#import "DBObj.h"
#import "AddressBook.h"



@interface RuntimeSampleViewController ()
@property (nonatomic,strong)UIButton *button;
@end

@implementation RuntimeSampleViewController


#pragma mark - def

#pragma mark - override
- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self closeConsole];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self openConsole];


//    NSLog(@" allSubClasses] %@",[DBObject allSubClasses]);
//    
    NSLog(@" allMethods] %@",[NSObject allMethods]);

    NSLog(@" callstack] %@",[DBObject callstack:64]);
    
    NSLog(@" allProperties] %@",[DBObj allProperties]);
    
    NSLog(@" allProtocol] %@",[UITableView allProtocol]);

    NSLog(@" allIvar] %@",[UITableView allIvar]);
    
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t N = { "N", "" }; //
    objc_property_attribute_t ownership = { "&", "" }; //
    objc_property_attribute_t backingivar  = { "V", "_Name" };
    objc_property_attribute_t attrs[] = { type, ownership,N, backingivar};
    class_addProperty([AddressBook class], "name1", attrs, 4);
    class_replaceProperty([AddressBook class], "name1", attrs, 4);
    
    
    AddressBook *obj = [[AddressBook alloc] init];

    
    
    ////    https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW1
        id LenderClass = objc_getClass("AddressBook");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "----%s %s\n", property_getName(property), property_getAttributes(property));
    }
    
    [AddressBook addProperty:@"age1" withValue:@"20"];
    [obj addProperty:@"age" withValue:@"20"];
    NSString *age = [obj getPropertyValue:@"age"];
    NSLog(@"age%@",age);
    
    NSLog(@"[AddressBook allProperties] %@",[AddressBook allProperties]);
    
    [obj  allProperties_each:^(NSString *key, NSString *value, BOOL *stop) {
        NSLog(@"key:%@,value:%@",key,value);
    }];
    
    
    NSArray *arr = [NSObject classesWithProtocol:@"NSCoding"];
    
    
    NSLog(@" allIvar] %@",[AddressBook allIvar]);
    
    {
        //定义一个 Person 类, 继承自 NSObject
//        Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
//        //添加属性
//        class_addIvar(Person, "_privateName", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
//        objc_property_attribute_t type = { "T", "@\"NSString\"" };
//        objc_property_attribute_t ownership = { "C", "" }; // C = copy
//        objc_property_attribute_t backingivar  = { "V", "_privateName" };
//        objc_property_attribute_t attrs[] = { type, ownership, backingivar };
//        class_addProperty(Person, "name", attrs, 3);
//        //添加方法
//        class_addMethod(Person, @selector(name), (IMP)nameGetter, "@@:");
//        class_addMethod(Person, @selector(setName:), (IMP)nameSetter, "v@:@");
//        //注册该类
//        objc_registerClassPair(Person);
//        
//        //获取实例
//        id instance = [[Person alloc] init];
//        NSLog(@"%@", instance);
//        [instance setName:@"hxn"];
//         NSLog(@"name:%@", [instance name]);

//        objc_disposeClassPair(Person);
        
    }
    
    {
        objc_property_attribute_t type = { "T", "@\"NSString\"" };
        objc_property_attribute_t ownership = { "C", "" }; // C = copy
        objc_property_attribute_t backingivar  = { "V", "_privateNameS" };
        objc_property_attribute_t attrs[] = { type, ownership, backingivar };
        class_addProperty([AddressBook class], "name", attrs, 3);
        class_addMethod([AddressBook class], @selector(name), (IMP)nameGetter, "@@:");
        class_addMethod([AddressBook class], @selector(setName:), (IMP)nameSetter, "v@:@");
        
        id o = [AddressBook new];
        NSLog(@"%@", [o name]);
        [o setName:@"Jobs"];
        NSLog(@"%@", [o name]);
    }
}



NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    return object_getIvar(self, ivar);
}

void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -
@end
