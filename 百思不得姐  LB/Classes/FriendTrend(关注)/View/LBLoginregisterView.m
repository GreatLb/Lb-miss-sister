//
//  LBLoginRegisterView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBLoginRegisterView.h"
@interface LBLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation LBLoginRegisterView


-(void)awakeFromNib{
    UIImage *image = [_loginButton backgroundImageForState:UIControlStateNormal];
    
    image =[image  stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
    [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
}

+(instancetype)loginView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

+(instancetype)registerView{
    
    return [[[NSBundle  mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}
@end
