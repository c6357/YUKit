//
//  YUKeychain.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

//https://github.com/square/Valet
#import "Valet.h"

//https://github.com/soffes/SAMKeychain

@interface YUKeychain : NSObject

/// @param string An NSString value to store in the keychain for the provided key.
/// @return NO if the keychain is not accessible.
+ (nullable VALValet*)setStringWithIdentifier:(nonnull NSString *)identifier string:(nonnull NSString *)string forKey:(nonnull NSString *)key;

/// @return The string currently stored in the keychain for the provided key. Returns nil if no string exists in the keychain for the specified key, or if the keychain is inaccessible.
+ (nullable NSString *)stringForKeyWithIdentifier:(nonnull NSString *)identifier forKey:(nonnull NSString *)key;



+ (void)save:(nullable NSString *)service data:(nullable id)data;
+ (nullable id)load:(nullable NSString *)service;
+ (void)deleteData:(nullable NSString *)service;

@end
