//
//  NSData+YUBase64.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YUBase64)
+ (NSData *)yu_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)yu_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)yu_base64EncodedString;
@end
