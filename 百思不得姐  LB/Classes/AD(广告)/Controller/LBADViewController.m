//
//  LBADViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/5.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBADViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import  "LBADItem.h"
#import  "LBTabBarController.h"
@interface LBADViewController ()
@property(nonatomic, strong)LBADItem *item;
@property(nonatomic,  weak)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@end
#define iPhone6P (LBScreenH == 736)
#define iPhone6  (LBScreenH == 667)
#define iPhone5  (LBScreenH == 568)
#define iPhone4  (LBScreenH == 480)
#define LBCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@implementation LBADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setupLanuchImage];
    [self loadDate];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

-(void)loadDate{
    //创建请求会话管理者
    AFHTTPSessionManager *mage = [AFHTTPSessionManager manager];
    
    mage.responseSerializer = [AFJSONResponseSerializer serializer];
    mage.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html", nil];
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = LBCode2 ;
    
    //发送get  请求
    [mage GET:@"http://mobads.baidu.com/cpro/ui/mads.php"parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
       //请求成功
        //获取广告字典
        NSDictionary *adDict =[responseObject[@"ad"]firstObject];
        LBADItem *item =[LBADItem mj_objectWithKeyValues:adDict];
        _item =item;
        //创建广告图片层
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.userInteractionEnabled =YES;
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [imageV addGestureRecognizer:tap];
        
        //添加到中间uiview上
        [_containerView  addSubview:imageV];
    
        [imageV sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        
        CGFloat w = LBScreenW;
        if(item.w <= 0) return ;
        CGFloat h = w / item.w * item.h;
        imageV.frame = CGRectMake(0, 0, w, h);
       
        //生成plist  文件到路径
//        [responseObject  writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/启动图片/ad.plist" atomically:YES];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"%@",error);
    }];
}
- (IBAction)jump:(UIButton *)sender {
    LBTabBarController *tabBarVC = [[LBTabBarController  alloc]
    init];
    [UIApplication sharedApplication].keyWindow.rootViewController =tabBarVC;
    [_timer invalidate];//销毁定时器
}
-(void)tapClick{
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
-(void)setupLanuchImage{
    UIImage *image = nil;
    if(iPhone6P ){
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    if(iPhone6 ){
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }
    if(iPhone5 ){
        image = [UIImage imageNamed:@"LaunchImage-568h"];
    }
    if(iPhone4 ){
        image = [UIImage imageNamed:@"LaunchImage"];
    }
    _launchImageView.image = image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)timeChange{
    static int i = 3;
    i -- ;
    if(i == -1){
        [self jump:nil];
    }
    NSString *title = [NSString stringWithFormat:@"跳过(%d)",i];
    [_jumpButton  setTitle:title forState:UIControlStateNormal];
    
}

@end
