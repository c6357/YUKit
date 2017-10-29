//
//  UIWebView+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIWebView+YU.h"

@implementation UIWebView (YU)

NSMutableData* receivedData;

+(NSString *)yu_htmlTitleWithUrlString:(NSString*)urlString{
    
    NSString *UrlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    if(!UrlStr){
        UrlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    }
    
    if(!UrlStr){
        NSMutableURLRequest  *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setTimeoutInterval:5.0];
        
        receivedData = [[NSMutableData alloc] init];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request     delegate:self];
        if (connection == nil) {
            return nil;
        }
        
    }
    
    if (UrlStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            webView.delegate = self;
            webView.mediaPlaybackRequiresUserAction = NO;
            webView.mediaPlaybackAllowsAirPlay = NO;
            //            [ApplicationDelegate.window addSubview:webView];
        });
        
    }
    
    
    
    NSMutableString *titleStr  = nil;
    if (UrlStr) {
        
        NSRange range = [UrlStr rangeOfString:@"<title>"];
        
        if (range.location != NSNotFound) {
            NSMutableString *needTidyString=[NSMutableString stringWithString:[UrlStr substringFromIndex:range.location+range.length]];
            
            NSRange rang2=[needTidyString rangeOfString:@"</title>"];
            
            titleStr =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
            
            NSLog(@"titleStr == %@",titleStr);
        }
        
    }
    
    return titleStr;
}





- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
    
    [receivedData appendData:data];
}


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"send=%@ redirect=%@",request.URL,response.URL);
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
    //    NSString *results = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //    self.title ＝  [webViewstringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    //    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    [webView removeFromSuperview];
}

@end
