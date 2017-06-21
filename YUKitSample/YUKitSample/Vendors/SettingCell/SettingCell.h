//
//  SettingCell.h
//  YUSettingCell<https://github.com/c6357/YUSettingCell>
//
//  Created by Matthijs on 15/5/14.
//  Copyright (c) 2015年 Matthijs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ACCV_None,
    ACCV_Accessory,
    ACCV_Switch,
    ACCV_Custom
} SetInfoAccType;

typedef enum : NSUInteger {
    Input_TextField,
    Input_TextView
} Input_TextType;

//typedef void (^NillBlock_OBJ)(id obj);
//typedef void (^NillBlock_Nill)(void);



@class SettingInfo;
@interface SettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UITextField *describeTexField;
@property (weak, nonatomic) IBOutlet YUTextView *describeTexView;

-(void)setSetInfo:(SettingInfo *)setInfo;

@end




@interface SettingInfo : NSObject

+(SettingInfo*)initWithTitle:(NSString*)title desrc:(NSString*)desrc;

+(SettingInfo*)initWithEditTitle:(NSString*)title desrc:(NSString*)desrc eventBlock:(NillBlock_OBJ)eventBlock;

+(SettingInfo*)initWithEditTitle:(NSString*)title desrc:(NSString*)desrc  placeholder:(NSString*)placeholder eventBlock:(NillBlock_OBJ)eventBlock;

+(SettingInfo*)initWithSwitchTitle:(NSString*)title eventBlock:(NillBlock_OBJ)eventBlock;

+(SettingInfo*)initWithAccessoryTitle:(NSString*)title desrc:(NSString*)desrc  didSelectRowBlock:(NillBlock_Nill)didSelectRowBlock;


@property (nonatomic,strong) NSString *title;//主题

@property (nonatomic,strong) NSString *describe;//描述
@property (nonatomic,strong) NSString  *placeholder;

@property (nonatomic,strong) UIImage *iconImg;
@property (nonatomic,strong) NSString *iconUrl;

@property (nonatomic,assign) Input_TextType inputTextType;//默认输入控件为textfield 由于不想影响以前的使用，新增textView
@property (nonatomic,assign) SetInfoAccType accView;

@property (nonatomic,copy) NillBlock_OBJ eventBlock;

@property (nonatomic,copy) NillBlock_Nill didSelectRowBlock;

@property (nonatomic,assign) BOOL textEnable;//描述
@property (nonatomic,assign) BOOL switchON;
@property (nonatomic,assign) BOOL switchEnable;

@property (nonatomic,assign) float inputViewLeft;
@property (nonatomic,assign) float inputViewRight;

@property (nonatomic,assign) id handle;
@property (nonatomic,assign) SEL action;

@end
