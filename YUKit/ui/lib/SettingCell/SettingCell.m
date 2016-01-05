//
//  SettingCell.m
//  YUSettingCell<https://github.com/c6357/YUSettingCell>
//
//  Created by BruceYu on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "SettingCell.h"
#import <Masonry/Masonry.h>

@interface SettingCell()<UITextViewDelegate>
@property (strong, nonatomic)UISwitch *accessorySwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UITextField *describeTexField;
@property (weak, nonatomic) IBOutlet YUTextView *describeTexView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (nonatomic,strong) SettingInfo *setInfo;
@end

@implementation SettingCell
- (void)awakeFromNib
{
    // Initialization code
    self.iconImg.layer.borderWidth = 0.65f;
    self.iconImg.layer.cornerRadius = 8.0f;
    self.iconImg.layer.borderColor = [[UIColor colorWithWhite:.8 alpha:1.0] CGColor];
    self.iconImg.layer.masksToBounds = YES;
    
    [self.describeTexField setTextColor:[UIColor darkGrayColor]];
    
//    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)setSetInfo:(SettingInfo *)setInfo
{
    self.titleLab.text = nil;
    self.iconImg.image = nil;
    _setInfo = setInfo;
    
    
    self.titleLab.text = setInfo.title;
    self.iconImg.image = setInfo.iconImg;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (setInfo.action && setInfo.handle){
        [setInfo.handle performSelector:setInfo.action withObject:nil];
    }
#pragma clang diagnostic po
    
    self.accessoryView = nil;
    switch (setInfo.accView) {
        case ACCV_Accessory:
        {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        case ACCV_None:
        {
            self.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
            
        case ACCV_Switch:
        {
            self.accessoryView = self.accessorySwitch;
            [self.accessorySwitch setOn:setInfo.switchON animated:false];
            self.accessorySwitch.userInteractionEnabled = setInfo.switchEnable;
        }
            break;
            
        default:
            self.accessoryType = UITableViewCellAccessoryNone;
            break;
    }

    
    ///////////////desrc
    self.describeTexField.userInteractionEnabled = NO;
    self.describeTexView.userInteractionEnabled = NO;
    switch (setInfo.inputTextType) {
        case Input_TextField:
        {
            self.describeTexField.delegate = setInfo.handle?:nil;
            self.describeTexField.text = setInfo.describe;
            self.describeTexField.userInteractionEnabled = setInfo.textEnable;
            self.describeTexField.backgroundColor = [UIColor clearColor];
        }
            break;
            
        case Input_TextView:
        {
            self.describeTexView.delegate = setInfo.handle?:nil;
            self.describeTexView.text = setInfo.describe;
            self.describeTexView.userInteractionEnabled = setInfo.textEnable;
            self.describeTexView.backgroundColor = [UIColor clearColor];
        }
            break;
            
        default:
            break;
    }
}


//添加约束问题待解决
-(void)updateConstraints{
    
//    [self.iconImg mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.offset(self.setInfo.iconImg?28:0);
//    }];


    
    
//    if (self.setInfo.accView == ACCV_None) {
//        [self.describeTexField mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-36);
//        }];
//    }
//    else if (self.setInfo.accView == ACCV_Switch){
//        [self.describeTexField mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-8);
//        }];
//        [self.describeTexView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-8);
//        }];
//    }
    
    
   [super updateConstraints];
}


#pragma mark - Event Handler -
- (IBAction)textfieldEvent:(UITextField*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(((UITextField*)sender).text);
    }
    self.setInfo.describe = sender.text;
}


-(IBAction)textViewDidChange:(UITextView *)textView{
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(textView.text);
    }
    self.setInfo.describe = textView.text;
}


- (IBAction)switchEvent:(UISwitch*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock((UISwitch*)sender);
    }
    self.setInfo.switchON = sender.on;
}

-(UISwitch *)accessorySwitch{
    if (!_accessorySwitch) {
        _accessorySwitch = [[UISwitch alloc] init];
        _accessorySwitch.onTintColor = [UIColor blueColor];
    }
    return _accessorySwitch;
}
@end

@implementation SettingInfo
+(SettingInfo*)initWithTitle:(NSString*)title desrc:(NSString*)desrc{
    SettingInfo *info = [[SettingInfo alloc] init];
    info.title = title;
    info.describe = desrc;
    return info;
}

+(SettingInfo*)initWithEditTitle:(NSString*)title desrc:(NSString*)desrc eventBlock:(NillBlock_OBJ)eventBlock{
    SettingInfo *info = [[SettingInfo alloc] init];
    info.title = title;
    info.describe = desrc;
    info.textEnable = YES;
    info.eventBlock = eventBlock;
    return info;
}

+(SettingInfo*)initWithSwitchTitle:(NSString*)title eventBlock:(NillBlock_OBJ)eventBlock{
    SettingInfo *info = [SettingInfo initWithTitle:title desrc:@""];
    info.accView = ACCV_Switch;
    info.eventBlock = eventBlock;
    return info;
}

+(SettingInfo*)initWithAccessoryTitle:(NSString*)title desrc:(NSString*)desrc  didSelectRowBlock:(NillBlock_Nill)didSelectRowBlock{
    SettingInfo *info = [SettingInfo initWithTitle:title desrc:desrc];
    info.didSelectRowBlock = didSelectRowBlock;
    return info;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = nil;
        self.describe = nil;
        self.action = nil;
        self.handle = nil;
        self.switchON = YES;
        self.switchEnable = YES;
        self.textEnable = NO;
        
        self.accView = ACCV_None;
        self.inputTextType = Input_TextField;
    }
    return self;
}
@end
