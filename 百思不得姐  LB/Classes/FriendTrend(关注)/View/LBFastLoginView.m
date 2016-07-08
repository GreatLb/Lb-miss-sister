//
//  LBFastLoginView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFastLoginView.h"

@implementation LBFastLoginView

+(instancetype)fastLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
@end
