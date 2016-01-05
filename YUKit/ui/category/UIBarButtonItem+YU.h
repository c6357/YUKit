//
//  UIBarButtonItem+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YU)

+(UIBarButtonItem*)buttonItemWith:(id)VC sel:(SEL)sel;


+(UIBarButtonItem *)rightTitleBtn:(id)VC Title:(NSString *)Title;


+(UIBarButtonItem *)leftTitleBtn:(id)VC Title:(NSString *)Title;

@end
