//
//  LBThemeButtonVIew.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/15.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeButtonVIew.h"
#import "LBThemeItem.h"
#import <UIImageView+WebCache.h>
@interface   LBThemeButtonVIew ()
@property (weak, nonatomic) IBOutlet UIButton *dingView;
@property (weak, nonatomic) IBOutlet UIButton *caiView;

@property (weak, nonatomic) IBOutlet UIButton *repostView;
@property (weak, nonatomic) IBOutlet UIButton *commentView;

@end
@implementation LBThemeButtonVIew
-(void)setItem:(LBThemeItem *)item{
    
    [super setItem:item];
    [self setUpButtonTitle:_dingView count:item.ding title:@"顶"];
    [self setUpButtonTitle:_caiView count:item.cai title:@"猜"];
    [self setUpButtonTitle:_repostView count:item.repost title:@"分享"];
    [self setUpButtonTitle:_commentView count:item.comment title:@"评论"];
    
}
-(void)setUpButtonTitle:(UIButton *)button  count:(NSInteger)count   title:(NSString *)title{
    if (count > 10000.0) {
        CGFloat  value = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万",value];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if(count > 0){
        title = [NSString stringWithFormat:@"%ld",(long)count];
    }
    [button setTitle:title forState: UIControlStateNormal];
    
    
    
    
}
@end
