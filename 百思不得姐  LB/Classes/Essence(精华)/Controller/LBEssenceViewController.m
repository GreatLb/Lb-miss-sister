//
//  LBEssenceViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBEssenceViewController.h"
#import "LbAllViewController.h"
#import "LBVoiceViewController.h"
#import "LBVideoViewController.h"
#import "LBTextViewController.h"
#import "LBPictureViewController.h"

@interface LBEssenceViewController ()

@end

@implementation LBEssenceViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpAllChildViewcontroller];  //添加所有子控制器
    
    [self  setupNavigationBar];

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
    
    //段子
    LBTextViewController *textVc = [[LBTextViewController  alloc]init];
    textVc.title =@"段子";
    [self addChildViewController:textVc];
    
}
-(void)setupNavigationBar{
    
    self.navigationItem.titleView =[[UIImageView alloc]initWithImage:[UIImage   imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] target:self action:@selector(gameClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem  itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage  imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
}

-(void)gameClick{
    
    NSLog(@"点击了精华左侧按钮");
}

@end
