//
//  YU_APP.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AssetsLibrary/AssetsLibrary.h>


typedef void (^NillBlock_Asset)(ALAsset* obj);

@interface YUAPP : NSObject

+(void)call:(NSString*)phoneNo;

/*
 打开一个网址
 */
+(void)openUrl:(NSString *)inUrl;

/*
 程序中播放一段简短的音乐
 @param  fName  @"MusicName"
 @param  ext  @"wav"@"mp3"。。
 */
+(void)playSound : (NSString *) fName : (NSString *) ext;


+(void)getPhotoAlbum :(NillBlock_Asset)Asset;


@end
