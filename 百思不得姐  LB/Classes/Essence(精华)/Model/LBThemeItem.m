//
//  LBThemeItem.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeItem.h"
#import "LBCommentItem.h"
#import <MJExtension/MJExtension.h>
@implementation LBThemeItem

-(void)setTop_cmt:(NSArray *)top_cmt{
    _top_cmt =top_cmt;
    if (top_cmt.count) {
        NSDictionary *commentDict = top_cmt.firstObject;
        _hotCommentItem = [LBCommentItem mj_objectWithKeyValues:commentDict];
    }
}
@end
