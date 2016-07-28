//
//  LBNavigationController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/5.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBNavigationController.h"

@interface LBNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LBNavigationController
+(void)load{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont  boldSystemFontOfSize:22];
    UINavigationBar *bar = [UINavigationBar  appearanceWhenContainedIn:self, nil];
    [bar setTitleTextAttributes:dict];
    // 设置背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //使系统边缘滑动手势不可用(失效)
    self.interactivePopGestureRecognizer.enabled = NO;
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer  alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    //handleNavgationTransition:  苹果内部私有的方法
    //添加手势
    [self.view addGestureRecognizer:pan];
    pan.delegate =self;
}
//是否出发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //在跟控制器下失效
    return  self.childViewControllers.count>1;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    if(self.childViewControllers.count){
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn  setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backBtn  sizeToFit];
    
    backBtn.contentEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //创建view  把按钮放上去  如果不添加到view上  按钮尺寸太大
    UIView *containView = [[UIView  alloc]initWithFrame:backBtn.bounds];
    [containView addSubview:backBtn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:containView];
    viewController.navigationItem.leftBarButtonItem =item;
    viewController.hidesBottomBarWhenPushed = YES;
        
    }
    //跳转控制器
    [super pushViewController:viewController animated:animated ];
}

-(void)back{
    [self  popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
