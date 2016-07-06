//
//  LBADItem.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/6.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBADItem : NSObject
// 为什么要使用strong
@property (nonatomic ,strong) NSString *w_picurl;
@property (nonatomic ,strong) NSString *ori_curl;
// MJExtension底层使用KVC,能转就会帮你转
@property (nonatomic ,assign) CGFloat w;
@property (nonatomic ,assign) CGFloat h;

@end
