//
//  UIView+YUFrame.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIView+YUFrame.h"

@implementation UIView (YUFrame)

CGFloat YU_VIEW_W(UIView* view){
    return YU_FRAME_W(view.frame);
}
CGFloat YU_VIEW_H(UIView* view){
    return YU_FRAME_H(view.frame);
}
CGFloat YU_VIEW_TX(UIView* view){
    return YU_FRAME_TX(view.frame);
}
CGFloat YU_VIEW_TY(UIView* view){
    return YU_FRAME_TY(view.frame);
}
CGFloat YU_VIEW_BX(UIView* view){
    return YU_FRAME_BX(view.frame);
}
CGFloat YU_VIEW_BY(UIView* view){
    return YU_FRAME_BY(view.frame);
}
CGFloat YU_FRAME_W(CGRect frame){
    return frame.size.width;
}
CGFloat YU_FRAME_H(CGRect frame){
    return frame.size.height;
}
CGFloat YU_FRAME_TX(CGRect frame){
    return frame.origin.x;
}
CGFloat YU_FRAME_TY(CGRect frame){
    return frame.origin.y;
}
CGFloat YU_FRAME_BX(CGRect frame){
    return frame.origin.x + frame.size.width;
}
CGFloat YU_FRAME_BY(CGRect frame){
    return frame.origin.y + frame.size.height;
}
-(CGFloat)YU_W{
    return YU_VIEW_W(self);
}
-(CGFloat)YU_H{
    return YU_VIEW_H(self);
}
-(CGFloat)YU_TX{
    return YU_VIEW_TX(self);
}
-(CGFloat)YU_TY{
    return YU_VIEW_TY(self);
}
-(CGFloat)YU_BX{
    return YU_VIEW_BX(self);
}
-(CGFloat)YU_BY{
    return YU_VIEW_BY(self);
}



- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}
@end
