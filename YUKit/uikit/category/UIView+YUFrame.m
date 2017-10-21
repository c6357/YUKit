//
//  UIView+YUFrame.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIView+YUFrame.h"

@implementation UIView (YUFrame)

CGFloat VIEW_W(UIView* view){
    return FRAME_W(view.frame);
}
CGFloat VIEW_H(UIView* view){
    return FRAME_H(view.frame);
}
CGFloat VIEW_TX(UIView* view){
    return FRAME_TX(view.frame);
}
CGFloat VIEW_TY(UIView* view){
    return FRAME_TY(view.frame);
}
CGFloat VIEW_BX(UIView* view){
    return FRAME_BX(view.frame);
}
CGFloat VIEW_BY(UIView* view){
    return FRAME_BY(view.frame);
}
CGFloat FRAME_W(CGRect frame){
    return frame.size.width;
}
CGFloat FRAME_H(CGRect frame){
    return frame.size.height;
}
CGFloat FRAME_TX(CGRect frame){
    return frame.origin.x;
}
CGFloat FRAME_TY(CGRect frame){
    return frame.origin.y;
}
CGFloat FRAME_BX(CGRect frame){
    return frame.origin.x + frame.size.width;
}
CGFloat FRAME_BY(CGRect frame){
    return frame.origin.y + frame.size.height;
}
-(CGFloat)W{
    return VIEW_W(self);
}
-(CGFloat)H{
    return VIEW_H(self);
}
-(CGFloat)TX{
    return VIEW_TX(self);
}
-(CGFloat)TY{
    return VIEW_TY(self);
}
-(CGFloat)BX{
    return VIEW_BX(self);
}
-(CGFloat)BY{
    return VIEW_BY(self);
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
