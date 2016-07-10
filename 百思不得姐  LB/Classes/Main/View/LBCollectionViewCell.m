//
//  LBCollectionViewCell.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/8.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBCollectionViewCell.h"
#import "LBMeSquareItem.h"
#import <UIImageView+WebCache.h>
@interface LBCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;


@end

@implementation LBCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
-(void)setItem:(LBMeSquareItem *)item{
    _item = item;
    [_iconView  sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
}
@end
