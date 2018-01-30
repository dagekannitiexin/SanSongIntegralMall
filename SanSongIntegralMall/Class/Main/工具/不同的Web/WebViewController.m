//
//  WebViewController.m
//  Shopping
//
//  Created by 林林尤达 on 2017/8/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController ()<NJKWebViewProgressDelegate>

@property(nonatomic,strong)NJKWebViewProgress * progressProxy;
@property(nonatomic,strong)NJKWebViewProgressView * progressView;

@end

@implementation WebViewController

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = [Utility getH5token:urlStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_web];
    
    _web.backgroundColor = [UIColor whiteColor];
    _web.allowsInlineMediaPlayback = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _web.scalesPageToFit = YES;
    
    _progressView =[[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    _progressView.progress = 0;
    [self.view addSubview:_progressView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _web.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_web loadRequest:request];
}

/*
 设置进度条
 */
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    JSContext *context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    
//    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
//        NSLog(@"%@", expectValue);
//    }];
//    
//    self.context = context;
//    self.context[@"native"] = self;
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    self.urlStr = request.URL.absoluteString;
    NSLog(@"%@",self.urlStr);
    return  YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
