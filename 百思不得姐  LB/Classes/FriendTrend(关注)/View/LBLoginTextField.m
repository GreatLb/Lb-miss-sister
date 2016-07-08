//
//  LBLoginTextField.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/8.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBLoginTextField.h"
#import "UITextField+placeholder.h"
@implementation LBLoginTextField
-(void)awakeFromNib{
    [super  awakeFromNib];
    self.tintColor =[UIColor whiteColor];
    [self addTarget:self action:@selector(textGegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    //    NSMutableDictionary *attr = [NSMutableDictionary  dictionary];
    //    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
    //    self.attributedPlaceholder =attStr;
    //初始化颜色
    self.placeholderColor = [UIColor lightGrayColor];
}
//开始编辑时
-(void)textGegin{
    //    NSMutableDictionary *attr = [NSMutableDictionary  dictionary];
    //    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
    self.placeholderColor =[UIColor whiteColor];
}
//退出编辑
-(void)textEnd{
    
    //    NSMutableDictionary *attr = [NSMutableDictionary  dictionary];
    //    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
    //    self.attributedPlaceholder =attStr;
    self.placeholderColor = [UIColor  lightGrayColor];
}

@end
