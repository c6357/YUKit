//
//  BaseView.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

@end
