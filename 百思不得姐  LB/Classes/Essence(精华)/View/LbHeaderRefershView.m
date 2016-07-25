//
//  LbHeaderRefershView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/21.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LbHeaderRefershView.h"
@interface LbHeaderRefershView (
)
@property (weak, nonatomic) IBOutlet UIView *loadView;
@property (weak, nonatomic) IBOutlet UIImageView *downView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;
@end
@implementation LbHeaderRefershView
-(void)setIsRefreshing:(BOOL)isRefreshing{
    
    _isRefreshing = isRefreshing;
    _loadView.hidden = !isRefreshing;
    
}

-(void)setIsVisable:(BOOL)isVisable{
    _isVisable = isVisable;
    _labelView.text = isVisable == NO ? @"下拉刷新" : @"松开立即刷新";
    [UIView animateWithDuration:0.2 animations:^{
        _downView.transform = isVisable == YES ? CGAffineTransformMakeRotation(-M_PI + 0.0001):CGAffineTransformIdentity;
    }];
}


-(void)awakeFromNib{
    //不要拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}

+(instancetype)headerRefershView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
@end
