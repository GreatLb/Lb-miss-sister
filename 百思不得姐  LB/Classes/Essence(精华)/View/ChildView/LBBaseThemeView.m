//
//  LBBaseThemeView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBBaseThemeView.h"

@implementation LBBaseThemeView

+(instancetype)ViewForXib{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];


}
@end
