//
//  UIViewController+Console.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/31.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIViewController+Console.h"
#import "UIColor+YU.h"
#import "NSObject+YU.h"
#import "NSNumber+YU.h"
#import <Masonry/Masonry.h>

static char fileHandleForReadingKey;
static char fileHandleForWritingKey;
static char pipeKey;
static char fileHandleForWritingDescriptorKey;
static char textViewKey;
static char buttonKey;
static int  sfd;
@implementation UIViewController (Console)

-(void)openConsole{
    sfd = dup(STDOUT_FILENO);
    self.pipe =  [NSPipe pipe];
    self.fileHandleForReading = [self.pipe fileHandleForReading];
    self.fileHandleForWriting = [self.pipe fileHandleForWriting];
    self.fileHandleForWritingDescriptor = [self.fileHandleForWriting fileDescriptor];
    
    self.textView = ({
        UITextView *textView = [UITextView new];
        textView.editable = NO;
        textView.font = [UIFont boldSystemFontOfSize:16];
        textView.textColor = [UIColor colorWithHexString:@"#0c6ce2"];
        textView.backgroundColor = [UIColor blackColor];
        textView;
    });
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self addBack];
    
    [self showDebug];
    
    [self setLandscape];
}


-(void)addBack{
    self.button = ({
        UIButton *button = [UIButton new];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view);
        make.width.offset(100);
        make.height.offset(60);
    }];
}


-(void)closeConsole{
    [self resume];
    
    if (self.pipe) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleReadCompletionNotification object:self.fileHandleForReading];
        
        close([self.fileHandleForWritingDescriptor intValue]);
        [self.fileHandleForReading closeFile];
        [self.fileHandleForWriting closeFile];
        
        //还原
        if (-1 == dup2(sfd,STDOUT_FILENO)) {
            NSLog(@"ERROR");
        }
        if (-1 == dup2(sfd,STDERR_FILENO)) {
            NSLog(@"ERROR");
        }
        close(sfd);
        self.pipe = nil;
    }
}



- (void)redirectNotificationHandle:(NSNotification *)notification {
    
    NSData *data = notification.userInfo[NSFileHandleNotificationDataItem];
    if (data.length) {
        NSString *string = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        self.textView.text = [self.textView.text stringByAppendingString:string];
        double delayInSeconds = 0.1;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            NSRange txtOutputRange;
            txtOutputRange.location = self.textView.text.length;
            txtOutputRange.length = 0;
            [self.textView scrollRangeToVisible:txtOutputRange];
            [self.textView setSelectedRange:txtOutputRange];
        });
        [notification.object readInBackgroundAndNotify];
        
    }else {
        [self performSelector:@selector(refreshLog:) withObject:notification afterDelay:1.0];
    }
}

- (void)refreshLog:(NSNotification *)notification {
    
    [notification.object readInBackgroundAndNotify];
}

-(void)backAction:(id)sender{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setLandscape{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    [self addBack];
}

-(void)resume{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - private

-(void)showDebug{
    
    //重定向
    if (-1 == dup2([self.fileHandleForWritingDescriptor intValue],STDOUT_FILENO)) {
        NSLog(@"ERROR");
    }
    
    if (-1 == dup2([self.fileHandleForWritingDescriptor intValue],STDERR_FILENO)) {
        NSLog(@"ERROR");
    }
    
    if(self.fileHandleForReading ){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(redirectNotificationHandle:)
                                                     name:NSFileHandleReadCompletionNotification
                                                   object:self.fileHandleForReading] ;
        [self.fileHandleForReading readInBackgroundAndNotify];
    }
}

#pragma mark - getter / setter
-(NSPipe*)pipe{
    return [self getAssociatedObjectForKey:&pipeKey];
}
-(NSFileHandle*)fileHandleForReading{
    return [self getAssociatedObjectForKey:&fileHandleForReadingKey];
}
-(NSFileHandle*)fileHandleForWriting{
    return [self getAssociatedObjectForKey:&fileHandleForWritingKey];
}
-(NSNumber*)fileHandleForWritingDescriptor{
    return [self getAssociatedObjectForKey:&fileHandleForWritingDescriptorKey];
}
-(UITextView *)textView
{
    return [self getAssociatedObjectForKey:&textViewKey];
}
-(UIButton *)button{
    return [self getAssociatedObjectForKey:&buttonKey];
}
-(void)setPipe:(NSPipe *)pipe{
    objc_setAssociatedObject(self, &pipeKey, pipe, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setFileHandleForReading:(NSFileHandle *)fileHandleForReading
{
    objc_setAssociatedObject(self, &fileHandleForReadingKey, fileHandleForReading, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setFileHandleForWriting:(NSFileHandle *)fileHandleForWriting
{
    objc_setAssociatedObject(self, &fileHandleForWritingKey, fileHandleForWriting, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setFileHandleForWritingDescriptor:(int)fileHandleForWritingDescriptor
{
    objc_setAssociatedObject(self, &fileHandleForWritingDescriptorKey, __INT(fileHandleForWritingDescriptor), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setTextView:(UITextView *)textView
{
    objc_setAssociatedObject(self, &textViewKey, textView, OBJC_ASSOCIATION_RETAIN);
}
-(void)setButton:(UIButton *)button{
    objc_setAssociatedObject(self, &buttonKey, button, OBJC_ASSOCIATION_RETAIN);
}
@end
