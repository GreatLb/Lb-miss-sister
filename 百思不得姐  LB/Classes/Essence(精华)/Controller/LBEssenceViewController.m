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
/*
 精华界面两部分
 底部: UIScrollView  5个UITableView, 左右滑动
 顶部: UIView
 
 离屏渲染:某些界面,虽然没有显示出来,只要添加到屏幕上,就一定会渲染.
 渲染也会创建很多对象,这样比较耗内存.
 优化:没有显示到屏幕上view,最后移除屏幕,这样就不会渲染这些界面
 UIScrollView:没有离屏渲染这样优化
 
 底部: UICollectionView  5个UITableView添加到cell, 左右滑动
 顶部: UIView => UIScrollView:利于扩展
 UICollectionView:功能:离屏渲染优化,当cell离开屏幕,移除屏幕,放在缓存池,当cell要显示的时候,马上从缓存池取
 如何处理缓存数据错乱:当cell从缓存池中取出来的时候,马上就把之前的子控制器的view移除屏幕,添加新的子控制器view添加上去
 当控制器的view移除屏幕的时候,也不会销毁,被控制器强引用
 */

@interface LBEssenceViewController ()

@end

@implementation LBEssenceViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    // 设置导航条内容 => 由导航控制器的栈顶控制器navigationItem决定
    [self  setupNavigationBar];
    //添加所有子控制器
    [self setUpAllChildViewcontroller];
    
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
