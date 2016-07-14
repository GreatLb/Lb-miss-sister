//
//  LBCommentItem.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBCommentItem.h"
#import "LBUserItem.h"
@implementation LBCommentItem
- (NSString *)totalCotent{
    return [NSString stringWithFormat:@"%@:%@",self.user.username,self.content];
}
@end
