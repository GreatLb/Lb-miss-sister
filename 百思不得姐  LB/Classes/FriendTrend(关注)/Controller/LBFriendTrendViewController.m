//
//  LBFriendTrendViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFriendTrendViewController.h"

@implementation LBFriendTrendViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blackColor];
    [self setupNavigationBar];
}
-(void)setupNavigationBar{ 
    self.navigationItem.title =@"关注";
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(RecommentClick)];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont  boldSystemFontOfSize:60];
    dict[NSFontAttributeName] = [UIFont  systemFontOfSize:15];
    [self.navigationController.navigationBar  setTitleTextAttributes:dict];
}
-(void)RecommentClick{
    NSLog(@"点击了关注左侧按钮");
}
@end
