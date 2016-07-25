//
//  LBCategoryCell.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/18.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBCategoryCell.h"
#import "LBCategoryItem.h"

@interface LBCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *inditorView;

@property (weak, nonatomic) IBOutlet UILabel *nameVIew;
@end


@implementation LBCategoryCell

-(void)setItem:(LBCategoryItem *)item{
    _item = item;
    _nameVIew.text = item.name;
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    _inditorView.hidden = !selected;
    
    _nameVIew.textColor = selected?[UIColor redColor]:[UIColor blackColor];
    
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
@end
