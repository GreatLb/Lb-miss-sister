//
//  LBEssenceViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBEssenceViewController.h"

@implementation LBEssenceViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    [self  setupNavigationBar];
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
