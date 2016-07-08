//
//  UITextField+placeholder.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/8.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "UITextField+placeholder.h"

@implementation UITextField (placeholder)
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
//NSMutableDictionary *attr = [NSMutableDictionary  dictionary];
//attr[NSForegroundColorAttributeName] = placeholderColor;
//NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attr];
//self.attributedPlaceholder =attStr;
    
    // 猜测占位文字是UILabel => 验证占位文字是UILabel(通过小面包查看当前界面是哪个类) => 设置占位文字颜色  => 拿到这个占位文字label做事情 => 苹果木有提供这样属性给我拿这个控件 => 思考:有些属性可能存在,但是是私有没有暴露给我们 => 查看下这个类私有属性名(1.runtime 2.断点) => KVC
    
    // 直接获取控件去设置
    UILabel *placeholderLabel = [self  valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}
@end
