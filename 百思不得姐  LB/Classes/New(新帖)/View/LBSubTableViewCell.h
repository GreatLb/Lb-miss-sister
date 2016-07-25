//
//  LBSubTableViewCell.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBSubTagItem,LBUserItem;
@interface LBSubTableViewCell : UITableViewCell
//+(instancetype)SubTagCell;
@property(nonatomic, strong)LBSubTagItem *item;
@property(nonatomic, strong)LBUserItem *userItem;
@property(nonatomic, assign)IBInspectable CGFloat imgCornerRadius;
@end
