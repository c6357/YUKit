//
//  NSFileManager+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (YU)

+ (NSString *)yu_pathForItemNamed:(NSString *)fname inFolder:(NSString *)path;
+ (NSString *)yu_pathForDocumentNamed:(NSString *)fname;
+ (NSString *)yu_pathForBundleDocumentNamed:(NSString *)fname;

+ (NSArray *)yu_pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)path;
+ (NSArray *)yu_pathsForDocumentsMatchingExtension:(NSString *)ext;
+ (NSArray *)yu_pathsForBundleDocumentsMatchingExtension:(NSString *)ext;

+ (NSArray *)yu_filesInFolder:(NSString *)path;

@end
