//
//  LBNewViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBNewViewController.h"
#import "LBSubTableViewController.h"

@implementation LBNewViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blueColor];
    [self setupNavigationBar];
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

@end
