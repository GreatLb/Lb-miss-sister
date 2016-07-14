//
//  LBThemeViewModel.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/13.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LBThemeItem;
@interface LBThemeViewModel : NSObject
@property(nonatomic, strong)LBThemeItem *item;
//顶部viewFrame
@property(nonatomic, assign)CGRect topViewFrame;

//顶部MiddleFrame
@property(nonatomic, assign)CGRect MiddleViewFrame;
//底部热论 hotCommentViewFrame
@property(nonatomic, assign)CGRect hotCommentViewFrame;

@property(nonatomic, assign)CGFloat cellH;
@end
