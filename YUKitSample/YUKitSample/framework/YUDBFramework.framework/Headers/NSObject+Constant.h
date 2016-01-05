//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
/*
 DB constant
 */

#ifndef YUDBObject_DB_Constant_h
#define YUDBObject_DB_Constant_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSObject+Config.h"


/*
 *  Support multiple data using FALASE OR TRUE
 
 *  Set TRUE customizable dbFolder () and dbName (), custom database location and file name
 
 *  Folder Path
 +(NSString*)dbFolder;
 *
 *  Database name
 +(NSString*)dbName;
 */
#define SupportMultipleDB TRUE


typedef NSObject* (^DB_Block_Dealize_Parser)(NSString *field,NSArray *array);

typedef Class (^DB_Block_ParserForArray)(NSString *field);

typedef Class (^DB_Block_ParserForArrayPlus)(NSString *field,id values);

typedef void (^DB_Block_ParserForArrayVoid)(NSString *field);

typedef void (^DB_Block_ParserForArrayVoidPlus)(NSString *field,BOOL *stop);


#if DBLogOpen
#    define DBLog(...) NSLog(__VA_ARGS__)
#else
#    define DBLog(...) {}
#endif

#if YUDBLogOpen
#    define YUDBLog(...) NSLog(__VA_ARGS__)
#else
#    define YUDBLog(...) {}
#endif


#define bundleName [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey]

#define IsSafeArray(a)              ((a)&&(![(a) isEqual:[NSNull null]]) &&((a).count>0))
#define IsSafeString(a)             ((a)&& (![(a) isEqual:[NSNull null]]) &&((a).length>0))

#define SafeString(a)               ((((a)==nil)||([(a) isEqual:[NSNull null]])||((a).length==0))?@"":(a))

#define SafeDBString(a)               ((((a)==nil)||([(a) isEqual:[NSNull null]])||((a).length==0))?@" ":(a))

#define SafeObj(a)               (((a)==nil)||([(a) isEqual:[NSNull null]]))?@"":(a)

#define IsSafeObj(a)   ((a)&&(![(a) isEqual:[NSNull null]]))

#define ComboString(string, args...)[NSString stringWithFormat:string,args]

#define ToString(args)[NSString stringWithFormat:@"%@",args]


#define YU_STATEMENT_Strong       @property(nonatomic,strong)
#define YU_STATEMENT_Assign       @property(nonatomic,assign)



#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif
#endif

#ifndef	strongify
#if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else
#define strongify( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif
#endif

/**
 *  Singleton
 */

#define SingletonH(name) + (instancetype)shared##name;

#if __has_feature(objc_arc)

#define SingletonM(name) \
static id _instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
}

#else

#define SingletonM(name) \
static id _instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
} \
\
- (oneway void)release { } \
- (id)retain { return self; } \
- (NSUInteger)retainCount { return 1;} \
- (id)autorelease { return self;}

#endif


#endif
