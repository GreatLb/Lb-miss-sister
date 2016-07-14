//
//  LBThemeCell.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeCell.h"
#import "LBThemeTopView.h"
#import "LBThemeViewModel.h"
#import "LBThemePictureView.h"
#import "LBThemeItem.h"
#import "LBThemeVoiceView.h"
#import "LBthemeVideoView.h"
#import "LBHotCommentView.h"

@interface LBThemeCell ()
@property(nonatomic,strong)LBThemeTopView *topView;
@property(nonatomic,strong)LBThemePictureView *PictureView;
@property(nonatomic,strong)LBThemeVoiceView *voiceView;
@property(nonatomic,strong)LBthemeVideoView *videoView;
@property(nonatomic,strong)LBHotCommentView *hotCommentView;
@end

@implementation LBThemeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //添加所有字结构
        
 //顶部
        LBThemeTopView *topView = [LBThemeTopView  ViewForXib];
        [self.contentView addSubview:topView];
        _topView = topView;
//中间
          //图片
        LBThemePictureView *pictureView =[LBThemePictureView ViewForXib];
        [self.contentView addSubview:pictureView];
        _PictureView = pictureView;
         //声音
        LBThemeVoiceView *voiceView =[LBThemeVoiceView ViewForXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
          //视频
        LBthemeVideoView *videoView =[LBthemeVideoView ViewForXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        
//最热评论
        LBHotCommentView *hotCommentView =[LBHotCommentView ViewForXib];
        [self.contentView addSubview:hotCommentView];
        _hotCommentView = hotCommentView;
   
 //底部
    }
    return self;
}


-(void)setVm:(LBThemeViewModel *)vm{
    _vm = vm;
    _topView.item = vm.item;
    _topView.frame = vm.topViewFrame;
    
    if(vm.item.type == LBThemeTypePicture ){
        _PictureView.hidden = NO;
        _voiceView.hidden = YES;
        _videoView.hidden = YES;
        
        _PictureView.item = vm.item;
        _PictureView.frame = vm.MiddleViewFrame;
    }else if (vm.item.type == LBThemeTypeVoice ){
        _PictureView.hidden = YES;
        _videoView.hidden = YES;
        _voiceView.hidden = NO;
        
        _voiceView.item = vm.item;
        _voiceView.frame = vm.MiddleViewFrame;
    }else if (vm.item.type == LBThemeTypeVideo ){
        _PictureView.hidden = YES;
        _voiceView.hidden = YES;
        
        _videoView.hidden =NO;
        _videoView.item = vm.item;
        _videoView.frame = vm.MiddleViewFrame;
        
    }else{
        
        _videoView.hidden = YES;
        _PictureView.hidden = YES;
        _voiceView.hidden = YES;

    }
    
    if(vm.item.hotCommentItem){
        _hotCommentView.hidden = NO;
        _hotCommentView.frame = _vm.hotCommentViewFrame;
        _hotCommentView.item = _vm.item;
        
    }else{
        _hotCommentView.hidden = NO;
    }

}

@end
