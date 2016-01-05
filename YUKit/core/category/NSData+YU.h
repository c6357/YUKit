//
//  NSData+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (YU)

@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)SHA1Sum;

/**
 Returns a string of the SHA256 sum of the receiver.
 
 @return The string of the SHA256 sum of the receiver.
 */
- (NSString *)SHA256Sum;


- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key;



- (NSString *)base64EncodedString;
+ (NSData *)dataFromBase64String:(NSString *)aString;


- (NSData *)DESEncryptWithKey:(NSString *)key;
- (NSData *)DESDecryptWithKey:(NSString *)key;


@end
