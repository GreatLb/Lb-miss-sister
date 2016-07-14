//
//  LBCommentItem.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LBUserItem;
@interface LBCommentItem : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) LBUserItem *user;
@property (nonatomic, strong) NSString *totalCotent;
@end
