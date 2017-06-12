//
//  UIView+YURotate360.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

enum i7Rotate360TimingMode {
    i7Rotate360TimingModeEaseInEaseOut,
    i7Rotate360TimingModeLinear
};


@interface UIView (YURotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode;

- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode;

- (void)rotate360WithDuration:(CGFloat)aDuration;

@end
