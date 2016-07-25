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
#import "LBSeeBigPictureController.h"
#import <DALabeledCircularProgressView.h>
@interface LBThemePictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureVIew;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation LBThemePictureView


-(void)awakeFromNib{
    [super awakeFromNib];
    //圆角半径
    _progressView.roundedCorners = 10;
    _progressView.progressLabel.textColor = [UIColor whiteColor];
    
}

+ (instancetype)viewForXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LBSeeBigPictureController  *vc = [[LBSeeBigPictureController  alloc]init];
    
    vc.item = _item;
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:vc animated:YES completion:nil];
    
}

-(void)setItem:(LBThemeItem *)item{
   
    _item = item;
   
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image0];
  
    //下载图片
    [_pictureVIew sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:image options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
        UIGraphicsBeginImageContextWithOptions(frame.size,NO, 0);
        [image drawInRect:frame];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [[SDImageCache sharedImageCache] storeImage:image forKey:item.image0];
        _pictureVIew.image =image;
    }] ;
    
//    }
    _gifImageView.hidden = !item.is_gif;
    //大图
    _seeBigPictureView.hidden = !item.is_bigPicture;
    //设置图片模式
    if(item.is_bigPicture){
        //如果是大图 回到图片顶部区域  并裁剪
        _pictureVIew.contentMode = UIViewContentModeTop;
        _pictureVIew.clipsToBounds =YES;
    }else {
        _pictureVIew.contentMode = UIViewContentModeScaleToFill;
        _pictureVIew.clipsToBounds = NO;
    }
    
}
//- (IBAction)seeBigPicture:(id)sender {
//    
//   
//}
@end
