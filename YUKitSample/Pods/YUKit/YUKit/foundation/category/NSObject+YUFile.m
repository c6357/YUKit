//
//  NSObject+YUFile.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSObject+YUFile.h"

@implementation NSObject (YUFile)

+(NSString*)fileString:(NSString*)name ext:(NSString*)ext{
    return [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)] encoding:NSUTF8StringEncoding error:nil];
}


+(NSDictionary*)fileDictionary:(NSString*)name ext:(NSString*)ext{
    return [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]];
}


+(NSArray*)FileArray:(NSString*)name ext:(NSString*)ext{
    return [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]];
}


+(void)setUserDefaults :(id)Obj forKey:(NSString*)Key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:Obj forKey:Key];
    [userDefault synchronize];
}


+(id)userDefaultsForKey:(NSString*)Key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:Key];
}



+(NSString*)modifyFileName:(NSString*)resourceFileName NewFileName:(NSString*)name Path:(NSString*)path
{
    NSFileManager*fileManager          = [NSFileManager defaultManager];

    NSString*resource                  = [NSString stringWithFormat:@"%@/%@",path,resourceFileName];

    NSString*NewName                   = [NSString stringWithFormat:@"%@/%@",path,name];

    if([fileManager moveItemAtPath:resource

                            toPath:NewName

                             error:nil])
    {
        NSLog(@"成功修改文件名==%@",NewName);
        return NewName;
    }

    NSLog(@"文件名字修改失败");
    return nil;
}


+ (long long) fileSizeAtPath:(NSString*) filePath{

    NSFileManager* manager             = [NSFileManager defaultManager];

    if ([manager fileExistsAtPath:filePath]){

        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;

}



+ (float ) folderSizeAtPath:(NSString*) folderPath{

    NSFileManager* manager             = [NSFileManager defaultManager];

    if (![manager fileExistsAtPath:folderPath]) return 0;

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString* fileName;

    long long folderSize               = 0;

    while ((fileName                   = [childFilesEnumerator nextObject]) != nil){

    NSString* fileAbsolutePath         = [folderPath stringByAppendingPathComponent:fileName];

    folderSize                         += [self fileSizeAtPath:fileAbsolutePath];

    }

    return folderSize/(1024.0*1024.0);
}


+ (NSMutableArray*)getFilePathInDocumentsDir:(NSString*)path{

    NSMutableArray *fileArray          = [[NSMutableArray alloc] init];

    NSFileManager *fileManager         = [NSFileManager defaultManager];

    NSDirectoryEnumerator *dirEnum     = [fileManager enumeratorAtPath:path];

    NSString *fileName;
    NSString *filePath;
    NSString *fileSize;
    NSString *fileDate;


    while (fileName                    = [dirEnum nextObject])
    {
        if(![fileName isEqualToString:@".DS_Store"])
        {

    filePath                           = [path stringByAppendingPathComponent:fileName];

    NSDictionary *fileAttributes       = [fileManager attributesOfItemAtPath:filePath error:nil];


            if ([fileAttributes objectForKey:NSFileSize])
            {
    fileSize                           = [fileAttributes objectForKey:NSFileSize];
            }

            if ([fileAttributes objectForKey:NSFileCreationDate])
            {
    fileDate                           = [fileAttributes objectForKey:NSFileCreationDate];
            }

            [fileArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  fileName,@"fileName",
                                  filePath,@"filePath",
                                  fileSize,@"fileSize",
                                  fileDate,@"fileDate",
                                  nil]];

        }
    }
    return fileArray;
}


+ (NSString*)createFileDirectories:(NSString*)Directories{

    NSString *FilePath                 = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                          stringByAppendingPathComponent:Directories];

    NSFileManager *fileManager         = [NSFileManager defaultManager];
    BOOL isDir                         = FALSE;
    BOOL isDirExist                    = [fileManager fileExistsAtPath:FilePath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
    BOOL bCreateDir                    = [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建失败！");
        }
        NSLog(@"创建目录 FilePath%@",FilePath);
    }
    return FilePath;
}



+ (NSString*)createTempDirectories:(NSString*)Directories{

    NSString *FilePath                 = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]
                          stringByAppendingPathComponent:Directories];

    NSFileManager *fileManager         = [NSFileManager defaultManager];
    BOOL isDir                         = FALSE;
    BOOL isDirExist                    = [fileManager fileExistsAtPath:FilePath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
    BOOL bCreateDir                    = [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建失败！");
        }
        NSLog(@"创建目录 FilePath%@",FilePath);
    }
    return FilePath;
}



+ (BOOL)removeItemAtPath:(NSString*)FilePath{

    NSFileManager *fileManager         = [NSFileManager defaultManager];

    BOOL isRemove                      = [fileManager removeItemAtPath:FilePath error:nil];

    if (isRemove)
    {
        NSLog(@"删除文件==%@ ",FilePath);
        return YES;
    }

    NSLog(@"删除文件失败！");
    return NO;
}

@end
