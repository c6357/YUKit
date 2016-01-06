//
//  UIWindow+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIWindow+YU.h"
#import "NSObject+YURuntime.h"
#import "NSObject+YU.h"

@implementation UIWindow (YU)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelectorWithClass:[UIWindow class] originalSelector:@selector(sendEvent:)  withSelector:@selector(mySendEvent:)];
    });
}

- (void)mySendEvent:(UIEvent *)event
{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if ( self == keyWindow && UIEventTypeTouches == event.type)
    {
        NSSet * allTouches = [event allTouches];
        if ( 1 == [allTouches count] )
        {
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            UIView *view = touch.view;
            if (!([[view superview] isKindOfClass:[UITableViewCell class]]||[[view superview] isKindOfClass:[UIScrollView class]])) {
                if ( 1 == [touch tapCount]  && UITouchPhaseBegan == touch.phase)
                {
                    [self addTouchAmimtion:touch];
                }else if ( 1 == [touch tapCount]  && UITouchPhaseMoved == touch.phase){
                    
                    [self addMoveAnimtion:touch];
                }
            }
        }
    }
    [self mySendEvent:event];
}

-(void)addMoveAnimtion:(UITouch *)touch{

}


-(void)addTouchAmimtion:(UITouch *)touch{
//    UIView *view = touch.view;
    CGPoint p = [touch locationInView:self];
    
//    view.layer.borderColor = [UIColor blueColor].CGColor;
//    [UIView animateWithDuration:.3 animations:^{
//        view.layer.borderWidth = 1;
//        //                        view.alpha = 0.3;
//    } completion:^(BOOL finished) {
//        [self afterBlock:^{
//            view.alpha = 1;
//            view.layer.borderWidth = .0;
//        } after:0.5];
//    }];
    
    float W = 66.;
    CALayer* layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(p.x-W/2, p.y-W/2, W, W);
    layer.cornerRadius = W/2;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.opacity = 0.5;
    layer.borderWidth = W/2;
    layer.borderColor = [UIColor colorWithWhite:.5 alpha:.9].CGColor;
    
    [self afterBlock:^{
        [UIView animateWithDuration:.4 animations:^{
            layer.borderWidth = 0.;
        } completion:^(BOOL finished) {
            
        }];
    } after:0.1];
    
    [self.layer addSublayer:layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    basicAnimation.toValue = [NSNumber numberWithFloat:1.];
    basicAnimation.duration = 0.3;
    basicAnimation.autoreverses = NO;
    basicAnimation.repeatCount = 1;
    basicAnimation.removedOnCompletion = YES;
    [layer addAnimation:basicAnimation forKey:nil];
    [self performSelector:@selector(hide:) withObject:@{@"CALayer":layer} afterDelay:0.4];
}

-(void)hide:(NSDictionary*)dict{
    
    CALayer *layer = [dict objectForKey:@"CALayer"];
    [UIView animateWithDuration:0.25 delay:0 options:0 << 16 animations:^{
        [layer removeFromSuperlayer];
    } completion:^(BOOL finished) {
        
    }];
}
@end

@implementation UIView (Debug)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self swizzleSelectorWithClass:[self class] originalSelector:@selector(init) withSelector:@selector(init_debug)];
        
        [self swizzleSelectorWithClass:[self class] originalSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_debug)];
        
        [self swizzleSelectorWithClass:[self class] originalSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_debug:)];
        
        [self swizzleSelectorWithClass:[self class] originalSelector:@selector(setFrame:) withSelector:@selector(setFrame_debug:)];
    });
}

-(id)init_debug{
    
    self = [self init_debug];
    [self commonInitialization];
    return self;
}

-(void)awakeFromNib_debug{
    [self commonInitialization];
}

-(id)initWithFrame_debug:(CGRect)frame{
    self = [self initWithFrame_debug:frame];
    [self commonInitialization];
    return self;
}

-(void)setFrame_debug:(CGRect)frame{
    
    [self setFrame_debug:frame];
}


-(void)commonInitialization{
    //在此添加通用初始化设置
    
}


-(void)showViewFrames{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.f/[UIScreen mainScreen].scale;
}


-(void)showViewFrameSize{
    
    DebugView *debugView = [[DebugView alloc]initWithFrame:self.bounds];
    [self addSubview:debugView];
}


@end

@implementation DebugView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    const CGFloat padding = 5;
    const CGFloat arrowLength = 5;
    UIFont *font = [UIFont fontWithName: @"Helvetica" size: 8];
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    
    CGRect frame = [self convertRect:self.frame fromView:self.superview];
    CGContextSetLineWidth(context, 1.0);
    
    
    //FOR WIDTH
    //Drawing Lines
    CGPoint originW = CGPointMake(frame.origin.x+padding, frame.origin.y+frame.size.height-2*padding+3.1);
    CGFloat lineW = frame.size.width-4*padding;
    
    CGContextMoveToPoint(context, originW.x,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW/2-2*padding,originW.y);
    CGContextMoveToPoint(context, originW.x+lineW/2+2*padding,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW,originW.y);
    //Drawing Arrows
    CGContextMoveToPoint(context, originW.x, originW.y);
    CGContextAddLineToPoint(context,originW.x+arrowLength*sqrtf(3)/2, originW.y+arrowLength/2);
    CGContextMoveToPoint(context, originW.x, originW.y);
    CGContextAddLineToPoint(context, originW.x+arrowLength*sqrtf(3)/2, originW.y-arrowLength/2);
    
    CGContextMoveToPoint(context, originW.x+lineW,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW-arrowLength*sqrtf(3)/2, originW.y+arrowLength/2);
    CGContextMoveToPoint(context, originW.x+lineW,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW-arrowLength*sqrtf(3)/2, originW.y-arrowLength/2);
    //Drawing Text
    CGPoint textCenterW =CGPointMake(originW.x+lineW/2-padding, originW.y-padding/2-2.5);
    NSString *stringW = [NSString stringWithFormat:@"%0.f",frame.size.width];
    [stringW drawAtPoint:textCenterW withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    
    
    //FOR HEIGHT
    //Drawing Lines
    CGPoint originH = CGPointMake(frame.origin.x+frame.size.width-2*padding, frame.origin.y+padding);
    CGFloat lineH = frame.size.height-2*padding;
    
    CGContextMoveToPoint(context,originH.x,originH.y);
    CGContextAddLineToPoint(context, originH.x, originH.y+lineH/2-2*padding);
    CGContextMoveToPoint(context, originH.x,originH.y+lineH/2+2*padding);
    CGContextAddLineToPoint(context,originH.x,originH.y+lineH);
    //Drawing Arrows
    CGContextMoveToPoint(context, originH.x, originH.y);
    CGContextAddLineToPoint(context,originH.x+arrowLength/2, originH.y+arrowLength*sqrtf(3)/2);
    CGContextMoveToPoint(context, originH.x, originH.y);
    CGContextAddLineToPoint(context, originH.x-arrowLength/2, originH.y+arrowLength*sqrtf(3)/2);
    
    CGContextMoveToPoint(context, originH.x,originH.y+lineH);
    CGContextAddLineToPoint(context,originH.x+arrowLength/2, originH.y+lineH-arrowLength*sqrtf(3)/2);
    CGContextMoveToPoint(context, originH.x,originH.y+lineH);
    CGContextAddLineToPoint(context,originH.x-arrowLength/2, originH.y+lineH-arrowLength*sqrtf(3)/2);
    
    //Drawing Text
    //粗略估计宽度
    NSString *heightStr = [NSString stringWithFormat:@"%@",@(frame.size.height)];
    CGPoint textCenterH =CGPointMake(originH.x-padding/2-(heightStr.length*1.5), originH.y+lineH/2-padding);
    NSString *stringH = [NSString stringWithFormat:@"%0.f",frame.size.height];
    [stringH drawAtPoint:textCenterH withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    
    //Drawing View's name in the top-right corner
//    NSString *className =  NSStringFromClass([self.superview class]);
//    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    /// Set line break mode
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
//    /// Set text alignment
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    NSDictionary *attributes = @{ NSFontAttributeName: font,
//                                  NSForegroundColorAttributeName: [UIColor blackColor],
//                                  NSParagraphStyleAttributeName: paragraphStyle };
    
//    CGSize size = [className sizeWithAttributes:attributes];
//
//    CGPoint originName = CGPointMake(padding+size.width/2, frame.origin.y+padding);
//    [className drawAtPoint:originName withAttributes:attributes];
    
    CGContextStrokePath(context);
    
}
@end
