//
//  NSFileManager+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "NSFileManager+YU.h"
#import "YUKit.h"

@implementation NSFileManager (YU)

+ (NSString *)yu_pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
    NSString *file;
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file lastPathComponent] isEqualToString:fname])
            return [path stringByAppendingPathComponent:file];
    return nil;
}

+ (NSString *)yu_pathForDocumentNamed: (NSString *) fname
{
    return [NSFileManager yu_pathForItemNamed:fname inFolder:YU_AppDocumentsPath()];
}

+ (NSString *)yu_pathForBundleDocumentNamed: (NSString *) fname
{
    return [NSFileManager yu_pathForItemNamed:fname inFolder:YU_AppBundlePath()];
}

+ (NSArray *)yu_filesInFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
    {
        BOOL isDir;
        [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:file] isDirectory: &isDir];
        if (!isDir) [results addObject:file];
    }
    return results;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *)yu_pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
            [results addObject:[path stringByAppendingPathComponent:file]];
    return results;
}

+ (NSArray *)yu_pathsForDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager yu_pathsForItemsMatchingExtension:ext inFolder:YU_AppDocumentsPath()];
}

// Case insensitive compare
+ (NSArray *)yu_pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager yu_pathsForItemsMatchingExtension:ext inFolder:YU_AppBundlePath()];
}


@end
