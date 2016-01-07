//
//  YU_TextView.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_TextView.h"
#import "YUKit.h"


@interface YUTextView()
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, retain) UIView *fullView;

@property (nonatomic, retain) UIColor* realTextColor;
@property (nonatomic, readonly) NSString* realText;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;
@end

@implementation YUTextView
@synthesize placeholder;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    self.realTextColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark Setter/Getters

- (void) setPlaceholder:(NSString *)aPlaceholder {
    if ([self.realText isEqualToString:placeholder]) {
        self.text = aPlaceholder;
    }
    
    placeholder = aPlaceholder;
    [self endEditing:nil];
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void) setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil) {
        super.text = self.placeholder;
    }
    else {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder]) {
        self.textColor = [UIColor lightGrayColor];
    }
    else {
        self.textColor = self.realTextColor;
    }
}

- (NSString *) realText {
    return [super text];
}

- (void) beginEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
    }
}

- (void) endEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        super.text = self.placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}

- (void) setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:[UIColor lightGrayColor]]) [super setTextColor:textColor];
        else self.realTextColor = textColor;
    }else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([self.text length]>0) {
        if (action == @selector(selectAll:) ||action ==@selector(select:) || action == @selector(copy:) || action == @selector(paste:)){
            return [super canPerformAction:action withSender:sender];
        }
    }
    if (action == @selector(paste:) ) {
        return [super canPerformAction:action withSender:sender];
    }
    return NO;
}

#pragma mark - interFace
-(void)setToFit
{
    NSString *currentText = self.text;
    CGRect TitleRect = self.frame;
    CGSize actualsize;
    
    if(isiOS7()){
        NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
        actualsize = [currentText boundingRectWithSize:CGSizeMake(self.frame.size.width, 980) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        WarnIgnore_Deprecate(actualsize = [currentText sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 980)lineBreakMode:NSLineBreakByWordWrapping];);
    }
    TitleRect.size.height = actualsize.height+10;
    self.frame = TitleRect;
}
@end