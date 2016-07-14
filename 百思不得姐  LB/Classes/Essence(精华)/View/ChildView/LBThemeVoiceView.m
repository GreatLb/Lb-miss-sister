//
//  LBThemeVoiceView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeVoiceView.h"
#import "LBThemeItem.h"
#import <UIImageView+WebCache.h>
@interface LBThemeVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountView;

@property (weak, nonatomic) IBOutlet UILabel *timerView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@end

@implementation LBThemeVoiceView
-(void)setItem:(LBThemeItem *)item{
    [super setItem:item];
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    _playCountView.text = [NSString stringWithFormat:@"%@播放",item.playcount];
    NSInteger minute = item.voicetime / 60 ;
    NSInteger second = item.voicetime % 60;
    _timerView.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    
}

@end
