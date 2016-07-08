//
//  LBLoginRegisterViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBLoginRegisterViewController.h"
#import "LBLoginRegisterView.h"
#import "LBFastLoginView.h"
@interface LBLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *LBFastLoginView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation LBLoginRegisterViewController
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册按钮点击
- (IBAction)registerBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    //移动中间View
    _leadCons.constant = _leadCons.constant == 0 ? -LBScreenW : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view  layoutIfNeeded];  //约束动画
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LBLoginRegisterView *loginView =[LBLoginRegisterView  loginView];
    [_middleView addSubview:loginView];
    
    LBLoginRegisterView *registerView =[LBLoginRegisterView  registerView];
    registerView.lb_x = [UIScreen  mainScreen].bounds.size.width;
    NSLog(@"%f",registerView.lb_x);
    [_middleView addSubview:registerView];
    
    LBFastLoginView *loginV =[LBFastLoginView  fastLoginView];
    [_LBFastLoginView addSubview:loginV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
