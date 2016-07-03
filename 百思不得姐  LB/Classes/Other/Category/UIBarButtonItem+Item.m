//
//  UIBarButtonItem+Item.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+(instancetype)itemWithImage:(UIImage *)image  highImage:(UIImage *)highImage  target:(id)target  action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn  sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containerView = [[UIView alloc]initWithFrame:btn.bounds];
    [containerView addSubview:btn];
    return  [[UIBarButtonItem  alloc]initWithCustomView:containerView
             ];
}
+(instancetype)itemWithImage:(UIImage *)image  selImage:(UIImage *)selImage  target:(id)target  action:(SEL)action{UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn  sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containerView = [[UIView alloc]initWithFrame:btn.bounds];
    [containerView addSubview:btn];
    return  [[UIBarButtonItem  alloc]initWithCustomView:containerView
             ];

    
}
@end
