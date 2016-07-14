//
//  LBThemePictureView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/13.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemePictureView.h"
#import "LBThemeItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <DALabeledCircularProgressView.h>
@interface LBThemePictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureInageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation LBThemePictureView


-(void)awakeFromNib{
    [super awakeFromNib];
    //圆角半径
    _progressView.roundedCorners = 10;
    _progressView.progressLabel.textColor = [UIColor whiteColor];
    
}
-(void)setItem:(LBThemeItem *)item{
    [super setItem:item];

   
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.cdn_img];
  
    //下载图片
    [_pictureInageVIew sd_setImageWithURL:[NSURL URLWithString:item.cdn_img] placeholderImage:image options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        if (progress  > 0) {
            _progressView.progress = progress;
            _progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(!item.is_bigPicture) return;
        CGFloat pictureW = LBScreenW - 20;
        CGFloat pictureH = pictureW / item .width *item.height;
        CGRect frame = CGRectMake(0, 0, pictureW, pictureH);
        UIGraphicsBeginImageContextWithOptions(frame.size
                                               , YES, 0);
        [image drawInRect:frame];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [[SDImageCache sharedImageCache] storeImage:image forKey:item.cdn_img];
        _pictureInageVIew.image =image;
    }] ;
        
//    }
    _gifImageView.hidden = !item.is_gif;
    //大图
    _seeBigImageBtn.hidden =!item.is_bigPicture;
    //设置图片模式
    if(item.is_bigPicture){
        //如果是大图 回到图片顶部区域  并裁剪
        _pictureInageVIew.contentMode = UIViewContentModeTop;
        _pictureInageVIew.clipsToBounds =YES;
    }else {
        _pictureInageVIew.contentMode = UIViewContentModeScaleToFill;
        _pictureInageVIew.clipsToBounds = NO;
    }
    
}

@end
