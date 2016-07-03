//
//  UIBarButtonItem+Item.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+(instancetype)itemWithImage:(UIImage *)image  highImage:(UIImage *)highImage  target:(id)target  action:(SEL)action;
+(instancetype)itemWithImage:(UIImage *)image  selImage:(UIImage *)selImage  target:(id)target  action:(SEL)action;
@end
