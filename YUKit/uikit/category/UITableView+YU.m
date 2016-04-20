//
//  UITableView+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UITableView+YU.h"
#import "YUKit.h"
#import "UIView+YU.h"

#define KBOUNCE_DISTANCE 7.
//#define KANIMATION_DURATION .7
#define YURoloadCellKey @"YURoloadCellKey"

@implementation UITableView (YU)

float oldOffset;
static float offsetX = 25;

-(void)yuScrollViewDidScroll:(UIScrollView *)scrollView Animation:(BOOL)animation{
    
    NSArray *cellArry = [self visibleCells];
    UITableViewCell *cellFirst = [cellArry firstObject];
    UITableViewCell *cellLast  = [cellArry lastObject];
    
    for (UITableViewCell *cell in cellArry) {
        
        {
            CGRect frame = cell.contentView.frame;
            frame.origin.y = 0;
            cell.contentView.frame = frame;
            cell.layer.zPosition = 0;
            cell.alpha = 1;
        };
        
        {
            CGRect frame = cell.frame;
            frame.origin.x = 0;
            frame.size.width = APP_WIDTH();
            cell.frame = frame;
        };
    }
    
    
    cellFirst.layer.zPosition = -1;
    cellLast.layer.zPosition = -1;
    
    
    if(!(scrollView.contentOffset.y <= 0 || scrollView.contentOffset.y >= (scrollView.contentSize.height-scrollView.frame.size.height)))
    {
        CGPoint point = [self convertPoint:[self rectForRowAtIndexPath:[self indexPathForCell:cellFirst]].origin toView:[self superview]];
        if(animation)
        {
            double py =  fabs(point.y);
            float scale;
            
            //if (scrollView.contentOffset.y > oldOffset)
            {
                scale = (py/cellFirst.H);
                cellFirst.alpha = 1-scale;
                
                CGRect frame = cellFirst.frame;
                frame.origin.x = offsetX*scale;
                frame.size.width = APP_WIDTH()-2*(offsetX*scale);
                cellFirst.frame = frame;
            }
            
            {
                scale = ((cellFirst.H-py)/cellFirst.H);
                cellLast.alpha = 1-scale;
                
                CGRect frame = cellLast.frame;
                frame.origin.x = offsetX*scale;
                frame.size.width = APP_WIDTH()-2*(offsetX*scale);
                cellLast.frame = frame;
            }
        }
        
        if(0 != point.y)
        {
            CGRect frame = cellFirst.contentView.frame;
            frame.origin.y = -point.y;
            cellFirst.contentView.frame = frame;
            
            frame = cellLast.contentView.frame;
            frame.origin.y = - frame.size.height - point.y;
            cellLast.contentView.frame = frame;
        }
    }
    
    oldOffset = scrollView.contentOffset.y;
}

- (CAAnimationGroup*)reloadDataAnimate:(YUAnimation)animation willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath duration:(CFTimeInterval)duration completion:(void(^)())completion{

    float i             = indexPath.row;
//    cell.layer.opacity = 0;
    
    CGPoint originPoint = cell.center;
    CGPoint beginPoint,endBounce1Point,endBounce2Point;
    CFTimeInterval d1=0,d4=0;
    

    if (animation == AnimationToLeft) {
        beginPoint          = CGPointMake(-originPoint.x, originPoint.y);
        endBounce1Point     = CGPointMake(originPoint.x-i*KBOUNCE_DISTANCE, originPoint.y);
        endBounce2Point     = CGPointMake(originPoint.x+i*KBOUNCE_DISTANCE, originPoint.y);
    }else{
        beginPoint          = CGPointMake(cell.frame.size.width, originPoint.y);
        endBounce1Point     = CGPointMake(originPoint.x+i*KBOUNCE_DISTANCE, originPoint.y);
        endBounce2Point     = CGPointMake(originPoint.x-i*KBOUNCE_DISTANCE, originPoint.y);
    }
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.keyTimes=@[[NSNumber numberWithFloat:d1=0.],
//                    [NSNumber numberWithFloat:d2=0.3],
//                    [NSNumber numberWithFloat:d3=0.6],
                    [NSNumber numberWithFloat:d4=0.8]];
    move.values=@[[NSValue valueWithCGPoint:beginPoint],
//                  [NSValue valueWithCGPoint:endBounce1Point],
//                  [NSValue valueWithCGPoint:endBounce2Point],
                  [NSValue valueWithCGPoint:originPoint]];
    move.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
 
    CFTimeInterval beginTime = CACurrentMediaTime()+0.05*i;
    
    
    
    
//    [self afterBlock:^{
//        cell.layer.opacity = 0;
//    } after:beginTime];
    

//    [self afterBlock:^{
//        if (completion) {
//            completion();
//        }
//        cell.layer.opacity = 1;
//    } after:0.1*i];

    
    CABasicAnimation *opaAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
    opaAnimation.fromValue         = @(0.f);
    opaAnimation.toValue           = @(0.8f);
    opaAnimation.autoreverses      = NO;
    opaAnimation.removedOnCompletion = NO;
    
    
    CAAnimationGroup *group        = [CAAnimationGroup animation];
    group.beginTime                = beginTime;
    group.animations               = @[move,opaAnimation];
    group.duration                 = duration;
    group.removedOnCompletion      = YES;
    group.fillMode                 = kCAFillModeForwards;
    group.delegate = self;
    [cell.layer addAnimation:group forKey:YURoloadCellKey];
    
    return group;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
}


#pragma mark -

-(void)yuReloadData
{
    [self yuReloadData:nil];
}

-(void)yuReloadData:(NSString*)message
{
    [self reloadData];
    if (self.numberOfSections == 0 || (self.numberOfSections == 1 && [self numberOfRowsInSection:0] == 0)) {
        [self showEmptyView:message];
    }
}


#define emptyViewTag 9999
-(void)showEmptyView:(NSString*)message
{
    UIView *v = [self viewWithTag:emptyViewTag];
    if (!v) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 80)];
        label.autoresizingMask =  UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        if (self.tableHeaderView) {
//            [label move:self.tableHeaderView.frame.size.height direct:Direct_Down animation:false];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        if (IsSafeString(message)) {
            label.text = message;
        }else{
            label.text = @"亲,没有数据可以显示哦!";
        }
        label.tag = 9999;
        label.alpha = 0;
        [self addSubview:label];
        [UIView animateWithDuration:1 animations:^{
            label.alpha = 1;
        }];
    }
}

-(void)hideEmptyView
{
    UIView *v = [self viewWithTag:emptyViewTag];
    if (v) {
        [v removeFromSuperview];
    }
}

@end
