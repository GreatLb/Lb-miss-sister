//
//  LBWebViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/9.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBWebViewController.h"
#import <WebKit/WebKit.h>
@interface LBWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property(nonatomic, weak)WKWebView *webView;


@end

@implementation LBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView =[[WKWebView alloc]initWithFrame:self.view.bounds];
    
    [_containerView addSubview:webView];
    _webView = webView;
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView  loadRequest:request];
    // KVO监听属性
    // KVO:有个注意点:一定要记得移除
    // 需要监听哪个对象,就给它添加观察者
    // KeyPath;观察属性
    // options:NSKeyValueObservingOptionNew
    //返回
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    //前进
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    // 头标题
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    //进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
//只要监听的属性有新值得时候就调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.title =_webView.title;
    _progress.hidden  = _webView.estimatedProgress >=1;
    _progress.progress= _webView.estimatedProgress;
    _backItem.enabled =_webView.canGoBack;
    _forwardItem.enabled =_webView.canGoForward;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [_webView  goBack];
}
- (IBAction)forwardBtnClick:(UIBarButtonItem *)sender {
    [_webView  goForward];
}
- (IBAction)refreshBtnClick:(UIBarButtonItem *)sender {
    [_webView  reload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
