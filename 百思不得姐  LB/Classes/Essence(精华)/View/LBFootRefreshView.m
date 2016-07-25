//
//  LBFootRefreshView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/19.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFootRefreshView.h"


@implementation LBFootRefreshView
-(void)awakeFromNib{
    //不要拉伸
    self.autoresizingMask =  UIViewAutoresizingNone;
}

+(instancetype)footRefreshView{
    
    return [[[NSBundle  mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

@end
