//
//  UIView+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIView+YU.h"
#import "UINavigationController+YU.h"
#import "NSString+YU.h"
#import <objc/runtime.h>
#import "NSObject+YU.h"
#import "YUKit.h"

#define CMM_AnimatePerior   0.35f
#define kAnimationPerior 0.35f


#define WP_TEXTSIZE(text, font, width ,mode) [text length] > 0 ? [text \
sizeWithFontX:font forWidth:width lineBreakMode:mode] : CGSizeZero;

#define WP_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFontX:font constrainedToSize:(maxSize) \
lineBreakMode:mode] : CGSizeZero;



@implementation UIView (YU)
-(CGFloat)W{
    return self.frame.size.width;
}

-(CGFloat)H{
    return self.frame.size.height;
}

-(CGFloat)TX{
    return self.frame.origin.x;
}

-(CGFloat)TY{
    return self.frame.origin.y;
}

-(CGFloat)BX{
    return (self.frame.origin.x + self.frame.size.width);
}

-(CGFloat)BY{
    return (self.frame.origin.y + self.frame.size.height );
}


static CGRect oldframe;
- (CAGradientLayer *)addLinearGradientWithColor:(UIColor *)theColor transparentToOpaque:(BOOL)transparentToOpaque
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //the gradient layer must be positioned at the origin of the view
    CGRect gradientFrame = self.frame;
    gradientFrame.origin.x = 0;
    gradientFrame.origin.y = 0;
    gradient.frame = gradientFrame;
    
    //build the colors array for the gradient
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[theColor CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.9f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.6f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.4f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.3f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.1f] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       nil];
    
    //reverse the color array if needed
    if(transparentToOpaque) {
        colors = [[colors reverseObjectEnumerator] allObjects];
    }
    
    //apply the colors and the gradient to the view
    gradient.colors = colors;
    
    [self.layer insertSublayer:gradient atIndex:(int)[self.layer.sublayers count]];
    
    return gradient;
}

- (UIView *)addOpacityWithColor:(UIColor *)theColor
{
    UIView *shadowView = [[UIView alloc] initWithFrame:self.bounds];
    
    [shadowView setBackgroundColor:[theColor colorWithAlphaComponent:0.8]];
    
    [self addSubview:shadowView];
    
    return shadowView;
}

- (UIImageView *) imageInNavController: (UINavigationController *) navController
{
    [self.layer setContentsScale:[[UIScreen mainScreen] scale]];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 1.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationHigh);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *currentView = [[UIImageView alloc] initWithImage: img];
    
    //Fix the position to handle status bar and navigation bar
    float yPosition = [navController calculateYPosition];
    [currentView setFrame:CGRectMake(0, yPosition, currentView.frame.size.width, currentView.frame.size.height)];
    
    return currentView;
}



+(id)XIBView
{
    id obj = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithUTF8String:object_getClassName(self)] owner:nil options:nil] objectAtIndex:0];
    return obj;
}



-(id)replacementForXibView
{
    UIView *old = self;
    UIView *new = [[self class] XIBView];
    [new setFrame:old.frame];
    [old.superview addSubview:new];
    [old removeFromSuperview];
    return new;
}


#pragma mark - ws
-(CAGradientLayer*)gradientLayer
{
    static NSString *layerIdentifier = @"gradient layer";
    
    CAGradientLayer *gradientLayer = Nil;
    
    for (CAGradientLayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:layerIdentifier]) {
            gradientLayer = layer;
            break;
        }
    }
    
    return gradientLayer;
}


-(void)setBackgroundWithGradientColor:(NSArray*)colors
{
    static NSString* layerName = @"gradient layer";
    
    self.backgroundColor = Nil;
    CAGradientLayer *gradientLayer = [self gradientLayer];
    
    if (!gradientLayer) {
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.name = layerName;
        gradientLayer.frame = self.bounds;
//        [self bk_addObserverForKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld task:^(id obj, NSDictionary *change) {
//            if ([self gradientLayer]) {
//                self.gradientLayer.frame = self.bounds;
//            }
//        }];
    }
    
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    gradientLayer.colors = cgColors;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
}

-(void)setFrame:(CGRect)frame animation:(BOOL)animated completion:(void(^)(BOOL))completion
{
    if (!animated) {
        [self setFrame:frame];
    } else {
        [UIView animateWithDuration:CMM_AnimatePerior animations:^{
            self.frame = frame;
        } completion:completion];
    }
}

-(void)move:(float)offset direct:(Direction)direction animation:(BOOL)animated
{
    CGRect rect = self.frame;
    switch (direction) {
        case Direct_Down:
            rect.origin.y += offset;
            break;
        case Direct_Up:
            rect.origin.y -= offset;
            break;
        case Direct_Left:
            rect.origin.x -= offset;
            break;
        case Direct_Right:
            rect.origin.x += offset;
            break;
    }
    
    [self setFrame:rect animation:animated completion:nil];
}

-(void)moveUp:(NSNumber*)offset animation:(BOOL)animated
{
    [self move:[offset floatValue] direct:Direct_Up animation:animated];
}

-(void)moveDown:(NSNumber*)offset animation:(BOOL)animated
{
    [self move:[offset floatValue] direct:Direct_Down animation:animated];
}

-(void)moveDown:(NSNumber*)offset
{
    [self move:[offset floatValue] direct:Direct_Down animation:false];
}

-(void)moevrTo:(CGPoint)nPoint animation:(BOOL)animated
{
    CGRect rect = self.frame;
    rect.origin.x = nPoint.x;
    rect.origin.y = nPoint.y;
    
    [self setFrame:rect animation:animated completion:nil];
}

-(void)moveToShowHide:(float)offset direct:(Direction)direction animation:(BOOL)animated
{
    CGRect rect = self.frame;
    switch (direction) {
        case Direct_Down:
            rect.origin.y += offset;
            break;
        case Direct_Up:
            rect.origin.y -= offset;
            break;
        case Direct_Left:
            rect.origin.x -= offset;
            break;
        case Direct_Right:
            rect.origin.x += offset;
            break;
    }
    
    
    BOOL hided = TRUE;
    if (self.superview) {
        CGRect sRect = self.superview.frame;
        sRect.origin.x = 0;
        sRect.origin.y = 0;
        if(CGRectIntersectsRect(sRect,rect)) hided = FALSE;
    }
    
    if (animated) {
        [UIView animateWithDuration:kAnimationPerior animations:^{
            self.frame = rect;
            self.alpha = hided ? 0.0f : 1.0f;
        }];
    } else {
        self.frame = rect;
        self.alpha = hided ? 0.0f : 1.0f;
    }
}

-(void)moveToHCenter:(BOOL)animated
{
    UIView *pv = self.superview;
    float width = pv.frame.size.width;
    
    float offset = (width - self.frame.size.width) /2 - self.frame.origin.x;
    
    [self move:offset direct:Direct_Right animation:animated];
}

-(void)strechTo:(CGSize)nSize animation:(BOOL)animated
{
    float widtih = nSize.width;
    float height = nSize.height;
    
    CGRect rect = self.frame;
    rect.size.width = widtih ;
    rect.size.height =height ;
    
    [self setFrame:rect animation:animated completion:nil];
}

-(void)strech:(float)offset direct:(Direction)direction animation:(BOOL)animated
{
    CGRect rect = self.frame;
    switch (direction) {
        case Direct_Down:
            rect.size.height += offset;
            break;
        case Direct_Up:
            rect.origin.y -= offset;
            rect.size.height += offset;
            break;
        case Direct_Left:
            rect.origin.x -= offset;
            rect.size.width += offset;
            break;
        case Direct_Right:
            rect.size.width += offset;
            break;
    }
    
    [self setFrame:rect animation:animated completion:nil];
}

-(void)setToSuperCenter
{
    CGPoint center = self.superview.center;
    center = [self.superview convertPoint:center fromView:self.superview.superview];
    [self setCenter:center];
}

-(void)setHidden:(BOOL)hidden animation:(BOOL)animation
{
    [self setHidden:hidden animation:animation completion:nil];
}

-(void)setHidden:(BOOL)hidden animation:(BOOL)animation completion:(void (^)(void))handler
{
    if (!animation) {
        [self setHidden:hidden];
        if (handler) handler();
    } else {
        float alpha = self.alpha;
        if (!hidden) {
            self.alpha  = 0.0f;
            self.hidden = FALSE;
        }
        
        [UIView animateWithDuration:kAnimationPerior animations:^{
            self.alpha = hidden ? 0.0f : alpha;
        } completion:^(BOOL finished) {
            if (finished) {
                self.alpha = alpha;
                self.hidden = hidden;
                if (handler) handler();
            }
        }];
    }
}

-(float)reAliginFollow:(UILabel*)label direct:(Direction)direction
{
    float offset = 0;
    float lableOffset = 0;
    
    switch (direction) { //self相对label的方位
        case Direct_Down:
        {
            if (IsSafeString(label.text) && !label.hidden) {
#if 1
                CGSize labsize = WP_MULTILINE_TEXTSIZE(label.text, label.font, CGSizeMake(label.frame.size.width, 9999), NSLineBreakByWordWrapping);
#else
                CGSize labsize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, 9999) lineBreakMode:NSLineBreakByWordWrapping];
#endif
                offset = lableOffset = labsize.height  - label.frame.size.height ;
            } else {
                offset = label.frame.origin.y - self.frame.origin.y;
                lableOffset = 0 - label.frame.size.height ;
            }
            
            [label strechTo:CGSizeMake(label.frame.size.width, label.frame.size.height + lableOffset) animation:false];
            [self moveDown:[NSNumber numberWithFloat:offset] animation:false];
            break;
        }
        case Direct_Up:
            break;
        case Direct_Left:
        {
            if (IsSafeString(label.text) && !label.hidden) {
#if 1
                CGSize labsize = WP_MULTILINE_TEXTSIZE(label.text, label.font, CGSizeMake(9999,label.frame.size.width), NSLineBreakByWordWrapping);
#else
                CGSize labsize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(9999, label.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
#endif
                offset = lableOffset = labsize.width  - label.frame.size.width ;
            } else {
                offset = label.frame.origin.x - self.frame.origin.x;
                lableOffset = 0 - label.frame.size.width ;
            }
            
            [label strechTo:CGSizeMake(label.frame.size.width + lableOffset, label.frame.size.height) animation:false];
            [label move:-lableOffset direct:Direct_Right animation:false];
            [self move:-offset direct:Direct_Right animation:false];
            break;
        }
        case Direct_Right:
        {
            if (IsSafeString(label.text) && !label.hidden) {
#if 1
                CGSize labsize = WP_MULTILINE_TEXTSIZE(label.text, label.font, CGSizeMake(9999,label.frame.size.width), NSLineBreakByWordWrapping);
#else
                CGSize labsize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(9999, label.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
#endif
                offset = lableOffset = labsize.width  - label.frame.size.width ;
            } else {
                offset = label.frame.origin.x - self.frame.origin.x;
                lableOffset = 0 - label.frame.size.width ;
            }
            
            [label strechTo:CGSizeMake(label.frame.size.width + lableOffset, label.frame.size.height) animation:false];
            [self move:offset direct:Direct_Right animation:false];
            break;
        }
    }
    return offset;
}

static char kClickGecognizer;


-(void)addClickGesture:(void (^)(void))handler
{
    [self removeClickGesture];
#if 1
    UIControl *maskControl = [[UIControl alloc] initWithFrame:self.bounds];
    [self addSubview:maskControl];
    [maskControl setBackgroundColor:[UIColor clearColor]];
//    [maskControl bk_addEventHandler:^(id sender) {
//        [maskControl removeFromSuperview];
//        if (handler) {
//            handler();
//        } else {
//            __weak id weakSelf = self;
//            [self setHidden:YES animation:YES completion:^{
//                [weakSelf removeFromSuperview];
//            }];
//        }
//    } forControlEvents:UIControlEventAllTouchEvents];
    objc_setAssociatedObject(self, &kClickGecognizer, maskControl, OBJC_ASSOCIATION_RETAIN);
#else
    UITapGestureRecognizer *gecognizer = [[UITapGestureRecognizer alloc]  bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (handler) {
            handler();
        } else {
            __weak id weakSelf = self;
            [self setHidden:YES animation:YES completion:^{
                [weakSelf removeFromSuperview];
            }];
        }
    }];
    
    gecognizer.numberOfTapsRequired = 1;
    gecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:gecognizer];
    objc_setAssociatedObject(self, &kClickGecognizer, gecognizer, OBJC_ASSOCIATION_RETAIN);
#endif
}

-(id)clickGesture
{
    return objc_getAssociatedObject(self, &kClickGecognizer);
}

-(void)removeClickGesture
{
#if 0
    if([self clickGesture]){
#if 1
        UIControl *v = [self clickGesture];
        [v bk_removeEventHandlersForControlEvents:UIControlEventAllTouchEvents];
        [v removeFromSuperview];
        objc_setAssociatedObject(self, &kClickGecognizer, nil, OBJC_ASSOCIATION_ASSIGN);
#else
        [self removeGestureRecognizer:[self clickGesture]];
#endif
    }
#endif
}

-(void)setWidth:(float)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    CGPoint center = self.center;
    self.frame = rect;
    self.center = center;
}

-(void)setHeight:(float)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(void)setHeight:(float)height animation:(BOOL)animtated
{
    if (animtated) {
        [UIView animateWithDuration:CMM_AnimatePerior animations:^{
            CGRect rect = self.frame;
            rect.size.height = height;
            self.frame = rect;
        }];
    } else {
        CGRect rect = self.frame;
        rect.size.height = height;
        self.frame = rect;
        
    }
    
}

-(void)setOrigin:(CGPoint)orgin
{
    CGRect rect = self.frame;
    rect.origin = orgin;
    self.frame = rect;
}

static char kIndexPath;

-(NSIndexPath*)IndexPath
{
    return (NSIndexPath*)objc_getAssociatedObject(self, &kIndexPath);
}

-(void)setIndexPath:(NSIndexPath*)indexPath
{
    objc_setAssociatedObject(self, &kIndexPath, indexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char KYu_Obj;
-(id)Obj
{
    return (NSIndexPath*)objc_getAssociatedObject(self, &KYu_Obj);
}

-(void)setObj:(id)obj{
    objc_setAssociatedObject(self, &KYu_Obj, obj, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


static char kAutoSize;
static char kChangeWithMe;
static bool hadExchanged = FALSE;


-(BOOL)autoSizeToFitContent
{
    return (BOOL)[objc_getAssociatedObject(self, &kAutoSize) boolValue];
}

-(void)setAutoSizeToFitContent:(BOOL)autoFit
{
    if ([self autoSizeToFitContent] == autoFit) {
        return;
    }
    if (!hadExchanged) {
        hadExchanged = TRUE;
        Method ori_Method =  class_getInstanceMethod([UIView class], @selector(addSubview:));
        Method my_Method = class_getInstanceMethod([UIView class], @selector(addMySubview:));
        method_exchangeImplementations(ori_Method, my_Method);
        
        ori_Method =  class_getInstanceMethod([UIView class], @selector(removeFromSuperview));
        my_Method = class_getInstanceMethod([UIView class], @selector(removeFromMySuperview));
        method_exchangeImplementations(ori_Method, my_Method);
        
    }
    
    
    objc_setAssociatedObject(self, &kAutoSize, [NSNumber numberWithBool:autoFit], OBJC_ASSOCIATION_COPY_NONATOMIC);
    //    self.autoresizesSubviews = !autoFit;
    
    for (UIView *subV in self.subviews){
        if (autoFit) {
            [subV addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:Nil];
        } else {
            [subV removeObserver:self forKeyPath:@"frame"];
        }
        
        //        if ((strcmp("UIButton", class_getName([subV class])) != 0) &&
        //            (strcmp("UITableViewCell", class_getName([subV class]) ) != 0) &&
        //            (strcmp("UITableView", class_getName([subV class]) ) != 0) &&
        //            (strcmp("UITextView", class_getName([subV class]) ) != 0) &&
        //            (strcmp("UITextField", class_getName([subV class]) ) != 0) &&
        //            (strcmp("WPSTTableViewCell", class_getName([subV class]) ) != 0)) {
        //            [subV setAutoSizeToFitContent:autoFit];
        //        }
    }
}

-(BOOL)changeWithMe
{
    return (BOOL)[objc_getAssociatedObject(self, &kChangeWithMe) boolValue];
}

-(void)setchangeWithMe:(BOOL)autoFit
{
    objc_setAssociatedObject(self, &kChangeWithMe, [NSNumber numberWithBool:autoFit], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"] && ![self changeWithMe]) {
        
        [self setchangeWithMe:YES];
        
        CGRect old = [[change valueForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGRect new = [[change valueForKey:NSKeyValueChangeNewKey] CGRectValue];
        
        UIOffset offset = UIOffsetMake(new.origin.x - old.origin.x, new.origin.y - old.origin.y);
        CGSize diff = CGSizeMake(new.size.width - old.size.width, new.size.height - old.size.height);
        
        for (UIView *subV in self.subviews) {
            if (subV.frame.origin.y > old.origin.y && subV != object) {
                CGRect newSubRect = subV.frame;
                //              newSubRect.origin.x += offset.horizontal;//目前忽略宽度变化
                newSubRect.origin.y += offset.vertical + diff.height;
                subV.frame = newSubRect;
            }
        }
        [self strechTo:CGSizeMake(self.frame.size.width, self.frame.size.height + diff.height) animation:FALSE];
        [self setchangeWithMe:FALSE];
        
    }
}


-(void)addMySubview:(UIView *)view
{
    [self addMySubview:view];
    if ([self autoSizeToFitContent]) {
        [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:Nil];
        //        [view setAutoSizeToFitContent:YES];
    }
}

-(void)removeFromMySuperview
{
    if ([self.superview autoSizeToFitContent]) {
        if (self.superview && [self.superview autoSizeToFitContent]) {
            [self removeObserver:self.superview forKeyPath:@"frame"];
        }
        //    [self setAutoSizeToFitContent:FALSE];
    }
    [self removeFromMySuperview];
}


static char kBorderStyle,kBorderWidth;

-(void)setViewBorderStyle:(NSInteger)viewBorderStyle
{
    objc_setAssociatedObject(self, &kBorderStyle, [NSNumber numberWithInt:(int)viewBorderStyle], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(void)setViewBorderLineWidth:(NSInteger)viewBorderLineWidth
{
    objc_setAssociatedObject(self, &kBorderWidth, [NSNumber numberWithInt:(int)viewBorderLineWidth], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if ([self viewBorderStyle] && viewBorderLineWidth) {
        if ([self viewBorderStyle] & BorderBottom) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
            v.backgroundColor = [UIColor colorWithCGColor:self.layer.borderColor];
            v.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            [self addSubview:v];
        }
        if ([self viewBorderStyle] & BorderTop) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
            v.backgroundColor = [UIColor colorWithCGColor:self.layer.borderColor];
            v.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
            [self addSubview:v];
        }
    }
}

-(NSInteger)viewBorderStyle
{
    return [objc_getAssociatedObject(self, &kBorderStyle)  intValue];
}

-(NSInteger)viewBorderLineWidth
{
    return [objc_getAssociatedObject(self, &kBorderWidth)  intValue];
    
}


static CGRect oldframe;
+(void)showImage:(UIButton*)headBtn{
    
    UIImage *image = headBtn.currentBackgroundImage;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    
    
    oldframe=[headBtn convertRect:headBtn.bounds toView:window];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    
    
    NillBlock_Nill ShowImg = ^{
        imageView.frame=CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y, 0, 0);
        [UIView animateWithDuration:0.35 animations:^{
            imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
            backgroundView.alpha = 1;
            imageView.alpha = 0.5;
        } completion:^(BOOL finished) {
            
        }];
    };
    
    
    ShowImg();
    
    
#define SP_width 60.f
    UIActivityIndicatorView* _spinnerView  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinnerView.frame = CGRectMake((backgroundView.W - SP_width)/2, (backgroundView.H - SP_width)/2, SP_width, SP_width);
    [backgroundView addSubview:_spinnerView];
    [_spinnerView startAnimating];
    
    [_spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    
    //    NSString *headUrl = [NSString stringWithFormat:DownloadHeadUrl,[SDataCenter userLogonInfo].accessToken,headBtn.OBJ];
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:headBtn.currentBackgroundImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        image = headBtn.currentBackgroundImage;
    //        [_spinnerView stopAnimating];
    //        imageView.alpha = 1 ;
    //    }];
}


+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIButton *imageView=(UIButton*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
@end
