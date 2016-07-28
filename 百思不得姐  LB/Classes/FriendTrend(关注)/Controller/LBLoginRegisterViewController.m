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
    _leadCons.constant = _leadCons.constant == 0 ? - LBScreenW : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view  layoutIfNeeded];  //约束动画
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加登陆view
    LBLoginRegisterView *loginView =[LBLoginRegisterView  loginView];
    [_middleView addSubview:loginView];
    //添加注册view
    LBLoginRegisterView *registerView =[LBLoginRegisterView  registerView];
    registerView.lb_x = [UIScreen  mainScreen].bounds.size.width;
    NSLog(@"%f",registerView.lb_x);
    [_middleView addSubview:registerView];
    //添加快速登陆View
    LBFastLoginView *loginV =[LBFastLoginView  fastLoginView];
    [_LBFastLoginView addSubview:loginV];
    
}
//布局子控件
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //登陆view 的位置
    LBLoginRegisterView *loginView = _middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, _middleView.lb_width* 0.5, _middleView.lb_height);
    //注册View 的位置
    LBLoginRegisterView *registerView = _middleView.subviews[1];
    registerView.frame = CGRectMake(_middleView.lb_width* 0.5, 0, _middleView.lb_width* 0.5, _middleView.lb_height);
   
    LBFastLoginView *loginV = _LBFastLoginView.subviews.firstObject;
    
    loginV.frame =_LBFastLoginView.bounds;



}

@end
