//
//  NSFileManager+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (YU)

+ (NSString *)pathForItemNamed:(NSString *)fname inFolder:(NSString *)path;
+ (NSString *)pathForDocumentNamed:(NSString *)fname;
+ (NSString *)pathForBundleDocumentNamed:(NSString *)fname;

+ (NSArray *)pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)path;
+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext;
+ (NSArray *)pathsForBundleDocumentsMatchingExtension:(NSString *)ext;

+ (NSArray *)filesInFolder:(NSString *)path;

@end
