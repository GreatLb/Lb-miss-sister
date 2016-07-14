//
//  LBThemeItem.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  LBCommentItem ;
typedef enum : NSInteger {
    LBThemeTypeAll = 1,
    LBThemeTypePicture = 10,
    LBThemeTypeVoice = 31,
    LBThemeTypeVideo = 41,
    LBThemeTypeText = 29
}LBThemeType;

@interface LBThemeItem : NSObject

/** 顶部 */
@property(nonatomic,strong)NSString *profile_image;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *created_at;

/** 照片*/

@property(nonatomic,strong)NSString *cdn_img;
@property(nonatomic,strong)NSString *image0;
@property(nonatomic,strong)NSString *image1;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,assign)BOOL   is_gif;
@property(nonatomic,assign)BOOL  is_bigPicture;
@property(nonatomic,assign)NSInteger width;
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)LBThemeType type;

/** 声音*/
@property(nonatomic,assign)NSInteger  voicetime;
@property(nonatomic,strong)NSString  *playcount;

//视频播放时间
@property(nonatomic,assign)NSInteger  videotime;

//最热评论数组
@property(nonatomic,assign)NSArray  *top_cmt;
@property(nonatomic,strong)LBCommentItem *hotCommentItem;
@end
