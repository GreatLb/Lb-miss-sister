//
//  LBHotCommentView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/14.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBHotCommentView.h"
#import "LBCommentItem.h"
#import "LBUserItem.h"
#import "LBThemeItem.h"
@interface LBHotCommentView ()
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *TotalView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation LBHotCommentView


-(void)setItem:(LBThemeItem *)item {
    [super setItem:item];
    if(item.hotCommentItem.content.length){
        _voiceView.hidden = YES;
        _TotalView.hidden = NO;
        _TotalView.text = item.hotCommentItem.totalCotent;
    }else{
        _voiceView.hidden = NO;
        _TotalView.hidden = YES;
        _nameView.text = [NSString stringWithFormat:@"%@:",item.hotCommentItem.user.username];
        [_voiceButton setTitle:item.hotCommentItem.voicetime forState:UIControlStateNormal];
    
    }
    
    
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
