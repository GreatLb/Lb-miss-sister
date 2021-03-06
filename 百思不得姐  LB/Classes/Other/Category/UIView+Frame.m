//
//  UIView+Frame.m
//  BuDeJie16
//
//  Created by xiaomage on 16/7/2.
//  Copyright © 2016年 seemygo. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)lb_x
{
    return self.frame.origin.x;
}

- (void)setLb_x:(CGFloat)lb_x
{
    CGRect frame = self.frame;
    frame.origin.x = lb_x;
    self.frame = frame;
}

- (CGFloat)lb_y
{
    return self.frame.origin.y;
}

- (void)setLb_y:(CGFloat)lb_y
{
    CGRect frame = self.frame;
    frame.origin.y = lb_y;
    self.frame = frame;
}

- (CGFloat)lb_width
{
    return self.frame.size.width;
}

- (void)setLb_width:(CGFloat)lb_width
{
    CGRect frame = self.frame;
    frame.size.width = lb_width;
    self.frame = frame;
}

- (CGFloat)lb_height
{
    return self.frame.size.height;
}

- (void)setLb_height:(CGFloat)lb_height
{
    CGRect frame = self.frame;
    frame.size.height = lb_height;
    self.frame = frame;
}
-(CGFloat)lb_centerX{
    return self.center.x;
    
}
-(void)setLb_centerX:(CGFloat)lb_centerX{
    CGPoint center = self.center;
    center.x = lb_centerX;
    self.center = center;
}

-(CGFloat)lb_centerY{
    return self.center.y;
}

-(void)setLb_centerY:(CGFloat)lb_centerY{
    CGPoint center =self.center;
    center.y = lb_centerY;
    self.center = center;

}
@end
