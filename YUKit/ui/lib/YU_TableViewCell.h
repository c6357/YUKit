//
//  YU_TableViewCell.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 支持多选，自定义AccessoryView
 */

@class YUTableViewCellSelectButton;
@interface YUTableViewCell : UITableViewCell

@property (nonatomic,copy) void (^yu_selectHndler)(void);

-(void)enableCellSelect:(void (^)(void))handler;


#pragma mark AccessoryView
-(void)hidesAccessoryView;

-(void)showAccessoryView;

-(void)setAccessoryViewWithImg:(UIImage*)img;

@property (strong, nonatomic) YUTableViewCellSelectButton *selectBtn;

@end



@interface YUTableViewCellSelectButton : UIButton

-(void)selected:(BOOL)selectBtn;

@end
