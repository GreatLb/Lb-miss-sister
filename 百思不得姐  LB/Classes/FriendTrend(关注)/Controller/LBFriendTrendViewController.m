//
//  LBFriendTrendViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFriendTrendViewController.h"
#import "LBLoginRegisterViewController.h"
#import "LBRecommendViewController.h"

@implementation LBFriendTrendViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    [self setupNavigationBar];
}
-(void)setupNavigationBar{ 
    self.navigationItem.title =@"关注";
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(RecommentClick)];
    }
-(void)RecommentClick{
    LBRecommendViewController *vc = [[LBRecommendViewController alloc]init];
    [self.navigationController  pushViewController:vc animated:YES];
    
}
- (IBAction)LoginRegisterBtnClick:(UIButton *)sender {
    
    LBLoginRegisterViewController *LoginRegisterVC = [[LBLoginRegisterViewController alloc]init];
    
    //moda  效果
    [self presentViewController:LoginRegisterVC animated:YES completion:nil];
    
}
@end
