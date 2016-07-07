//
//  LBSubTableViewCell.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBSubTableViewCell.h"
#import "LBSubTagItem.h"
#import <UIImageView+WebCache.h>
@interface LBSubTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation LBSubTableViewCell
+(instancetype)SubTagCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"cell" owner:nil options:nil]firstObject];
}

-(void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    frame.origin.x += 10;
    frame.size.width -=20;
    frame.size.height -=10;
    [super setFrame:frame];
}
// 头像变成圆形图形  两种方式
// 1.layer
// 2.图片裁剪
- (void)awakeFromNib {
    [super awakeFromNib];
//    //设置圆角半径
//    _iconView.layer.cornerRadius=_iconView.bounds.size.width*0.5;
//    //超出区域裁剪
//    _iconView.layer.masksToBounds = YES;
}

-(void)setItem:(LBSubTagItem *)item{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image ==nil) return;
        //开启图形上下文
        // opaque:不透明度 YES:黑色 NO:透明
        // scale:比例因子(像素与点比例) 0:自动识别当前比例因子
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //描述裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //设置裁剪区域
        [clipPath  addClip];
        //画图
        [image  drawAtPoint:CGPointZero];//x,y都从0点开始
        //从上下文中取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        //重新赋值
        _iconView.image = image;
    }];
    
    
    _nameLabel.text = item.theme_name;
   
    CGFloat num =[item.sub_number  floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%@人阅读",item.sub_number];
    if(num > 10000){
        num = num/10000;
        numStr = [NSString  stringWithFormat:@"%.1f万人阅读",num];
        numStr = [numStr  stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numLabel.text =numStr;
}

//订阅按钮点击
- (IBAction)subButnClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
