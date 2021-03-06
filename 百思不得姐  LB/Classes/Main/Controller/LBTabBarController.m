//
//  LBTabBarController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBTabBarController.h"
#import "LBMeViewController.h"
#import "LBNewViewController.h"
#import "LBEssenceViewController.h"
#import "LbPublishViewController.h"
#import "LBFriendTrendViewController.h"
#import "LBNavigationController.h"
//#import "UIImage+Image.h"
#import <MJExtension.h>
@interface LBTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic, weak)UIButton *plusButton;
@property(nonatomic,weak)UIViewController *lastVC;
@end
@implementation LBTabBarController


-(UIButton *)plusButton{
    if(_plusButton ==nil){
        UIButton *btn =[UIButton  buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage  imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        _plusButton = btn;
        [self.tabBar  addSubview:btn];
    }
    return _plusButton;
}


+(void)load{
    //设置全局的按钮文字颜色  不会被渲染
    UITabBarItem  *item = [UITabBarItem appearance];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    //选中状态下文字颜色
    [item  setTitleTextAttributes:dict forState:UIControlStateSelected];
    //设置正常状态下文字字体
    NSMutableDictionary *fonDict = [NSMutableDictionary  dictionary];
    fonDict [NSFontAttributeName] =[UIFont systemFontOfSize:15];

    [item setTitleTextAttributes:fonDict forState:UIControlStateNormal];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupAllChildViewController];
    [self setupAlltitleButton];
    
    self.plusButton.center =CGPointMake(self.tabBar.bounds.size.width *0.5, self.tabBar.lb_height *0.5);
    
    self.delegate = self;
    //默认第 0 个子控件为最后一个控件
    _lastVC = self.childViewControllers[0];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //判断是否重复点击
    if(_lastVC == viewController){
//        NSLog(@"重复点击");
        // 通知控制器,刷新表格
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatClickTitle" object:nil];
    }
    //判断是否重复点击了按钮
    _lastVC = viewController;
}
-(void)setupAlltitleButton{
    //0
    UIViewController  *vc = self.childViewControllers[0];
    vc.tabBarItem.title =@"精华";
    vc.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_essence_icon"];
    vc.tabBarItem.selectedImage = [UIImage  imageNamedWithOriginal:@"tabBar_essence_click_icon"];
    
    
    UIViewController  *vc3 = self.childViewControllers[1];
    vc3.tabBarItem.title =@"新帖";
    vc3.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_new_icon"];
    vc3.tabBarItem.selectedImage = [UIImage  imageNamedWithOriginal:@"tabBar_new_click_icon"];//1
    
   //2 发布
    UIViewController  *vc2 = self.childViewControllers[2];
    vc2.tabBarItem.enabled = YES;//系统创建的按钮处于不可点击状态
    
    //3
    UIViewController  *vc1 = self.childViewControllers[3];
    vc1.tabBarItem.title =@"关注";
    vc1.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_friendTrends_icon"];
    vc1.tabBarItem.selectedImage = [UIImage  imageNamedWithOriginal:@"tabBar_friendTrends_click_icon"];
    //4
    UIViewController  *vc4 = self.childViewControllers[4];
    vc4.tabBarItem.title =@"我";
    vc4.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage  imageNamedWithOriginal:@"tabBar_me_click_icon"];
    
}

-(void)setupAllChildViewController{
    //精华
    LBEssenceViewController *essenceVc =[[LBEssenceViewController alloc]init];
    LBNavigationController *nav = [[LBNavigationController alloc]initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    //创建新帖
    LBNewViewController *newVc =[[LBNewViewController alloc]init];
    LBNavigationController *nav1 = [[LBNavigationController alloc]initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    //发布
    LbPublishViewController *publishVc =[[LbPublishViewController alloc]init];
//    publishVc.view.backgroundColor =[UIColor blackColor];
    [self addChildViewController:publishVc];
    
    //关注
    LBFriendTrendViewController *friendTrendVc =[[LBFriendTrendViewController alloc]init];
    LBNavigationController *nav3 = [[LBNavigationController alloc]initWithRootViewController:friendTrendVc];
    [self addChildViewController:nav3];
    
    //我
    UIStoryboard *strodboard =[UIStoryboard  storyboardWithName:@"LBMeViewController" bundle:nil];
    LBMeViewController *meVc =[strodboard instantiateInitialViewController];  LBNavigationController *nav4 = [[LBNavigationController alloc]initWithRootViewController:meVc];
    [self addChildViewController:nav4];
    
}
@end
