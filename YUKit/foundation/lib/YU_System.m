//
//  YU_System.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_System.h"
#import "YUKit.h"



void yu_system_vibrate(){
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#define SOUNDID  1012  //1012 -iphone   1152 ipad  1109 ipad
void yu_system_sound()
{
    AudioServicesPlaySystemSound(SOUNDID);
}


static UIWebView *phoneCallWebView;
void yu_system_call(NSString *phoneNo)
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNo]];
    
    //[[UIApplication rsk_sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]]];
    if (phoneURL) {
        if (!phoneCallWebView) {
            phoneCallWebView =[[UIWebView alloc] init];
        }
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}

/*
 打开一个网址
 @param  inUrl http://www.iteye.com/blogs/tag/iOS
 */
void yu_system_openURL(NSString *url){
#ifndef TARGET_IS_EXTENSION
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];
        [[UIApplication sharedApplication] openURL:cleanURL];
    }else{
        NSString *textURL = [NSString stringWithFormat:@"http://%@",url];
        NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
        [[UIApplication sharedApplication] openURL:cleanURL];
    }
#endif
}


void yu_system_playSound(NSString *fName,NSString *ext)
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

void yu_system_soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}


SystemSoundID yu_system_creatSoundIDWithSoundName(NSString *soundName){
    
    NSString *audioFile = [[NSBundle mainBundle]pathForResource:soundName ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    if (err) {
        NSLog(@"Error occurred assigning system sound!");
        return -1;
    }
    
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, yu_system_soundCompleteCallback, NULL);
    return soundID;
}

void yu_system_playSoundWithSoundID(SystemSoundID soundID){
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
    //    AudioServicesPlayAlertSound(self.soundID);//播放音效并震动
}

void yu_system_stopSoundWithSoundID(SystemSoundID soundID){
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}


CTCarrier* yu_system_carrier()
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    
    NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    
    return carrier;
}

NSString* yu_system_carrierName(){
    
    NSString * mobileNetworkCode = yu_system_carrier().mobileNetworkCode;

    NSDictionary *MNCDic = @{@"00":@"中国移动",
                             @"01":@"中国联通",
                             @"02":@"中国移动",
                             @"03":@"中国电信",
                             @"05":@"中国电信",
                             @"06":@"中国联通",
                             @"07":@"中国移动",
                             @"20":@"中国铁通"
                             };
    if (MNCDic[mobileNetworkCode]) {
        return MNCDic[mobileNetworkCode];
    }
    
    return @"无法获取运营商";
}


//+(void)getPhotoAlbum :(NillBlock_Asset)Asset{
//    
//    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
//    
//    void (^selectionBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset,
//                                                            NSUInteger index,
//                                                            BOOL* innerStop) {
//        if (asset == nil) {
//            Asset(nil);
//            return;
//        }
//        Asset(asset);
//    };
//    
//    void (^enumerationBlock)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup* group, BOOL* stop) {
//        if (group) {
//            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//            NSUInteger index              = [group numberOfAssets] - 1;
//            NSIndexSet* lastPhotoIndexSet = [NSIndexSet indexSetWithIndex:index];
//            [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:selectionBlock];
//        }
//    };
//    
//    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
//                           usingBlock:enumerationBlock
//                         failureBlock:nil];
//    
//}

