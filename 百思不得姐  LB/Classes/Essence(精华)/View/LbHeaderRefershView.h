//
//  LbHeaderRefershView.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/21.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LbHeaderRefershView : UIView
@property(assign, nonatomic)BOOL isVisable;
@property (nonatomic, assign) BOOL isRefreshing;
+(instancetype)headerRefershView;
@end
