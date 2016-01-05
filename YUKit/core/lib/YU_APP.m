//
//  YU_APP.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_APP.h"


@implementation YUAPP
UIWebView *phoneCallWebView;
+(void)call:(NSString*)phoneNo
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNo]];
    
    //[[UIApplication rsk_sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]]];
    
    if (phoneURL) {
        if (!phoneCallWebView) {
            phoneCallWebView =[[UIWebView alloc] initWithFrame:CGRectZero];
        }
        //    = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}

/*
 打开一个网址
 @param  inUrl http://www.iteye.com/blogs/tag/iOS
 */
+ (void)openUrl:(NSString *)inUrl{
#ifndef TARGET_IS_EXTENSION
    if ([inUrl hasPrefix:@"http://"]) {
        NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", inUrl]];
        [[UIApplication sharedApplication] openURL:cleanURL];
    }else{
        NSString *textURL = [NSString stringWithFormat:@"http://%@",inUrl];
        NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
        [[UIApplication sharedApplication] openURL:cleanURL];
    }
#endif
}


/**
 程序中播放一段简短的音乐
 @param  fName  @"MusicName"
 @param  ext  @"wav"@"mp3"。。
 */
+(void)playSound : (NSString *) fName : (NSString *) ext
{
    
    NSString *path  = [[NSBundle mainBundle] pathForResource: fName ofType :ext];
    SystemSoundID audioEffect;
    if ([[NSFileManager defaultManager] fileExistsAtPath : path])
    {
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        // [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        AudioServicesPlaySystemSound(audioEffect);
    }else
    {
        NSLog(@"error, file not found: %@", path);
    }    
}


+(void)getPhotoAlbum :(NillBlock_Asset)Asset{
    
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    
    void (^selectionBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset,
                                                            NSUInteger index,
                                                            BOOL* innerStop) {
        if (asset == nil) {
            Asset(nil);
            return;
        }
        Asset(asset);
    };
    
    void (^enumerationBlock)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup* group, BOOL* stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            NSUInteger index              = [group numberOfAssets] - 1;
            NSIndexSet* lastPhotoIndexSet = [NSIndexSet indexSetWithIndex:index];
            [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:selectionBlock];
        }
    };
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:enumerationBlock
                         failureBlock:nil];
    
}
@end
