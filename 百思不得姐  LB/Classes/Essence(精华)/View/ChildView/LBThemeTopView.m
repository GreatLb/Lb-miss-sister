//
//  LBThemeTopView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeTopView.h"
#import <UIImageView+WebCache.h>
#import "LBThemeItem.h"

@interface  LBThemeTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UILabel *textView;

@end

@implementation LBThemeTopView


-(void)setItem:(LBThemeItem *)item{
    
    [super setItem:item];
    //头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
    //姓名
    _nameView.text = item.name;
    //时间
    _dateView.text = item.created_at;
    //文本
    _textView.text = item.text;
    
}
@end
