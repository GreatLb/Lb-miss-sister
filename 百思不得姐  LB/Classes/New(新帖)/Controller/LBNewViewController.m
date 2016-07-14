//
//  LBNewViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBNewViewController.h"
#import "LBSubTableViewController.h"
#import "LBEssenceViewController.h"
#import "LbAllViewController.h"
#import "LBVoiceViewController.h"
#import "LBVideoViewController.h"
//#import "LBTextViewController.h"
#import "LBPictureViewController.h"

@implementation LBNewViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self setUpAllChildViewcontroller];  //添加所有子控制器
    [self setupNavigationBar];
    self.view.backgroundColor =[UIColor blueColor];

}

-(void)setupNavigationBar{

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"]
        target:self action:@selector(MainTagSubIconClick)];
    
}

-(void)MainTagSubIconClick{
    LBSubTableViewController *subVC = [[LBSubTableViewController alloc]init];
    //跳转到推荐标签控制器
    [self.navigationController  pushViewController:subVC animated:YES];
}

-(void)setUpAllChildViewcontroller{
    
    //全部
    LbAllViewController *allVc = [[LbAllViewController  alloc]init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    //视频
    LBVideoViewController *videoVc = [[LBVideoViewController  alloc]init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    //声音
    LBVoiceViewController *voiceVc = [[LBVoiceViewController  alloc]init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    //图片
    LBPictureViewController *pictureVc = [[LBPictureViewController  alloc]init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
//    //段子
//    LBTextViewController *textVc = [[LBTextViewController  alloc]init];
//    textVc.title =@"段子";
//    [self addChildViewController:textVc];
    
}
@end
