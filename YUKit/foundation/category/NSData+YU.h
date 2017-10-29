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

@property(nonatomic,readonly,getter=yu_isEmpty) BOOL empty;

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)yu_MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)yu_SHA1Sum;

/**
 Returns a string of the SHA256 sum of the receiver.
 
 @return The string of the SHA256 sum of the receiver.
 */
- (NSString *)yu_SHA256Sum;




- (NSData *)yu_AES128Operation:(CCOperation)operation key:(NSString *)key;


- (NSData *)yu_DESEncryptWithKey:(NSString *)key;


- (NSData *)yu_DESDecryptWithKey:(NSString *)key;


@end




