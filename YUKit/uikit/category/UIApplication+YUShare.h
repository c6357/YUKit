//
//  UIApplication+YUShare.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The category `RSKSharedApplication` of the class `UIApplication` provides the method `rsk_sharedApplication` which returns `nil` in an application extension, otherwise it returns the singleton app instance.
 */
@interface UIApplication (YUShare)
/**
 Returns `nil` in an application extension, otherwise returns the singleton app instance.
 
 @return `nil` in an application extension, otherwise the app instance is created in the `UIApplicationMain` function.
 */
+ (UIApplication *)yu_sharedApplication;

+ (void)load;

@end
