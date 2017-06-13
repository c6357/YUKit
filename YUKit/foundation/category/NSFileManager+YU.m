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

+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
    NSString *file;
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file lastPathComponent] isEqualToString:fname])
            return [path stringByAppendingPathComponent:file];
    return nil;
}

+ (NSString *) pathForDocumentNamed: (NSString *) fname
{
    return [NSFileManager pathForItemNamed:fname inFolder:AppDocumentsPath()];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname
{
    return [NSFileManager pathForItemNamed:fname inFolder:AppBundlePath()];
}

+ (NSArray *) filesInFolder: (NSString *) path
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
+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
            [results addObject:[path stringByAppendingPathComponent:file]];
    return results;
}

+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:AppDocumentsPath()];
}

// Case insensitive compare
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:AppBundlePath()];
}


@end
