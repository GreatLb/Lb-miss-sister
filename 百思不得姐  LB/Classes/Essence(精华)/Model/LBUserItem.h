//
//  LBUserItem.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBUserItem : NSObject
@property(nonatomic, strong)NSString *username;

/**  推荐关注*/
@property(nonatomic, strong)NSString *screen_name;
@property(nonatomic, strong)NSString *header;
@property(nonatomic, strong)NSString *fans_count;
/**  推荐关注*/
@end
