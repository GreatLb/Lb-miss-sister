//
//  LBMeViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBMeViewController.h"
#import "LBSettingViewController.h"
@implementation LBMeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    [self setupNavigationBar];
}


-(void)setupNavigationBar{
    self.navigationItem.title=@"我的";
    UIBarButtonItem *setting =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    UIBarButtonItem *night= [UIBarButtonItem  itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage  imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightBtnClick:)];
    self.navigationItem.rightBarButtonItems =@[setting,night];
}

//设置按钮点击
-(void)settingClick{
    LBSettingViewController  *settingVC = [[LBSettingViewController  alloc]init];
    settingVC.hidesBottomBarWhenPushed =YES;
    [self.navigationController  pushViewController:settingVC animated:YES];
}
//夜间模式按钮点击
-(void)nightBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;//取反
}

@end
