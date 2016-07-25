//
//  LBthemeVideoView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBthemeVideoView.h"
#import "LBThemeItem.h"
#import <UIImageView+WebCache.h>
@interface LBthemeVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeView;


@end

@implementation LBthemeVideoView

-(void)setItem:(LBThemeItem *)item{
    [super setItem:item];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    
    _playCountView.text = item.playcount;
    CGFloat playCount = [item.playcount  floatValue];
    NSString *countStr = [NSString  stringWithFormat:@"%@播放",item.playcount];
    if(playCount > 10000){
        playCount = playCount / 10000.0;
        countStr = [NSString stringWithFormat:@"%.1f万播放",playCount];
        countStr = [countStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }
    _playCountView.text = countStr;
    
    NSInteger minute = item.videotime / 60;
    NSInteger second = item.videotime % 60;

    _playTimeView.text = [NSString stringWithFormat:@"%02ld :%02ld",minute,second];
    
    
}


@end
