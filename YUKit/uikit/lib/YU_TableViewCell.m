//
//  YU_TableViewCell.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_TableViewCell.h"
@interface YUTableViewCell()
@end

@implementation YUTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -
-(void)enableCellSelect:(void (^)(void))handler
{
    UITapGestureRecognizer *geconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select:)];
    [self addGestureRecognizer:geconizer];
    
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(select:)];
    [geconizer requireGestureRecognizerToFail:longPressGR];
    longPressGR.minimumPressDuration = .1;
    [self addGestureRecognizer:longPressGR];
    
    self.yu_selectHndler = handler;
}

-(void)select:(UITapGestureRecognizer*)gesture
{
    UITableViewCell *cell = self;
    
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [cell setSelected:YES];
        if (self.yu_selectHndler) {
            self.yu_selectHndler();
        }
        [cell setSelected:FALSE animated:YES];
    } else if (gesture.state == UIGestureRecognizerStateBegan) {
        [cell setSelected:YES];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture locationInView:cell];
        if (CGRectContainsPoint(cell.bounds, point)) {
            if (self.yu_selectHndler) {
                self.yu_selectHndler();
            }
        }
        [cell setSelected:FALSE animated:YES];
    } else if (gesture.state == UIGestureRecognizerStateCancelled) {
        [cell setSelected:FALSE animated:YES];
    }
}


#pragma mark -
-(void)hidesAccessoryView{
    [self setAccessoryViewWithImg:nil];
}

-(void)showAccessoryView{
    [self setAccessoryViewWithImg:[UIImage imageNamed:@"CMM_arrow_right"]];
}

-(void)setAccessoryViewWithImg:(UIImage*)img
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
    [imgView setImage:img];
    self.accessoryView = img?imgView:nil;
}

- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    [self addSubview:self.selectBtn];
    
    [super setEditing:editting animated:animated];

    if (editting){
        [self setCheckImageViewCenter:CGPointMake(22, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
    }else{
        
        [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(self.selectBtn.frame) * 0.5,
                                                  CGRectGetHeight(self.bounds) * 0.5)
                                alpha:0.0
                             animated:animated];
    }
}

- (void) setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated
{
    if (animated){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        self.selectBtn.center = pt;
        self.selectBtn.alpha = alpha;
        
        [UIView commitAnimations];
        
    }else{
        self.selectBtn.center = pt;
        self.selectBtn.alpha = alpha;
    }
}

-(YUTableViewCellSelectButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[YUTableViewCellSelectButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_selectBtn setImage:[UIImage imageNamed:@"CMM_list_click"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"CMM_list_ok"] forState:UIControlStateSelected];
        _selectBtn.center = CGPointMake(-CGRectGetWidth(_selectBtn.frame) * 0.5,
                                        CGRectGetHeight(self.bounds) * 0.5);
        _selectBtn.backgroundColor = [UIColor clearColor];
    }
    return _selectBtn;
}
@end


@implementation YUTableViewCellSelectButton
-(void)selected:(BOOL)selectBtn
{
    [self setImage:[UIImage imageNamed:selectBtn ? @"CMM_list_ok" :@"CMM_list_click"]forState:UIControlStateNormal];
}
@end

