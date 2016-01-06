//
//  UIBarButtonItem+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIBarButtonItem+YU.h"
#import "UIView+YU.h"
#import "NSString+YU.h"

@implementation UIBarButtonItem (YU)
+(UIBarButtonItem*)buttonItemWith:(id)VC sel:(SEL)sel
{
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"img_name"] forState:UIControlStateNormal];
    [rightBtn addTarget:VC action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}


+(UIBarButtonItem *) rightTitleBtn:(id)VC Title:(NSString *)Title{
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setTitle:Title forState:UIControlStateNormal];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [rightBtn addTarget:VC action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic po
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}


+(UIBarButtonItem *) leftTitleBtn:(id)VC Title:(NSString *)Title{
    UIButton * rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:Title forState:UIControlStateNormal];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [rightBtn addTarget:VC action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic po
    rightBtn.frame = CGRectMake(0, 0, [NSString LabSize:rightBtn.titleLabel.font labTex:Title].width, 24);
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
@end
