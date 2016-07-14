//
//  LBThemeViewModel.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/13.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeViewModel.h"
#import "LBThemeItem.h"
#import "LBUserItem.h"
#import "LBCommentItem.h"

@implementation LBThemeViewModel
-(void)setItem:(LBThemeItem *)item{
    _item = item;
    CGFloat margin = 10;
    CGFloat textY = 55;
    CGFloat textW= LBScreenW - margin * 2;
    CGFloat textH = [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT) ].height;
    CGFloat  topViewX = 0;
    CGFloat  topViewY = 0;
    CGFloat  topViewW = LBScreenW ;
    CGFloat  topViewH = textY + textH;
    
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    _cellH = CGRectGetMaxY(_topViewFrame) + margin;
    //不是段子是才需要计算
    if(item.type != LBThemeTypeText){
        CGFloat middleX = margin;
        CGFloat middleY = _cellH;
        CGFloat middleW =textW ;
        CGFloat middleH = 0;
        if(item.width > 0){
            middleH = middleW / item.width * item.height;
        }
        if(middleH > LBScreenH){
            middleH = 300;
            item.is_bigPicture =YES;
        }
        _MiddleViewFrame = CGRectMake(middleX, middleY,middleW, middleH);
        _cellH = CGRectGetMaxY(_MiddleViewFrame) + margin;
 
    }
    if (item.hotCommentItem) {
        CGFloat commentX = margin;
        CGFloat commentY = _cellH;

        CGFloat commentW = textW;

        CGFloat commentH = 42;
        if(item.hotCommentItem.content.length){
            CGFloat textH = [item.hotCommentItem.totalCotent  sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(commentW, MAXFLOAT)].height;
            commentH = 21 + textH;
       }
        _hotCommentViewFrame = CGRectMake(commentX, commentY, commentW, commentH);
        _cellH = CGRectGetMaxY(_hotCommentViewFrame) + margin;

 }
}
@end
