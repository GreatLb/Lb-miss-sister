//
//  LBFastLoginButton.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFastLoginButton.h"

@implementation LBFastLoginButton
-(void)layoutSubviews{
    [super layoutSubviews];
    //修改图片
    self.imageView.lb_centerX = self.lb_width *0.5;
    self.imageView.lb_y = 0;
    [self.titleLabel  sizeToFit];
    //修改文字
    self.titleLabel.lb_centerX = self.lb_width *0.5;
    self.titleLabel.lb_y = self.lb_height - self.titleLabel.lb_height;
}

@end
