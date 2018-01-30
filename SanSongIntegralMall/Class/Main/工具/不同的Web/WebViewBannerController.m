//
//  WebViewBannerController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "WebViewBannerController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewBannerController ()<NJKWebViewProgressDelegate>

@property(nonatomic,strong)NJKWebViewProgress * progressProxy;
@property(nonatomic,strong)NJKWebViewProgressView * progressView;

@end

@implementation WebViewBannerController

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = [Utility getH5token:urlStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD setForegroundColor:RGBACOLOR(255, 192, 203, 1)];
    [SVProgressHUD show];
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20)];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //当网页加载完全
    [SVProgressHUD dismiss];
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 32, 32)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
    //    backBtn.hidden = YES;
    [self.view addSubview:backBtn];
}
/*
 返回按钮
 */
- (void)btnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
