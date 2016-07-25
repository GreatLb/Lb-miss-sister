//
//  LBCategoryItem.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/18.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBCategoryItem : NSObject
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSString *name;

/**  当前分类推荐用户组*/
@property(nonatomic,strong)NSMutableArray *users;
/** 当前页数*/
@property(nonatomic,assign)NSInteger page;
/** 当前分类总页数*/
@property(nonatomic,assign)NSInteger total_page;
@end
