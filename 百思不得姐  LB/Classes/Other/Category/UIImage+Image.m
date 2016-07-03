//
//  UIImage+Image.m
//  BuDeJie16
//
//  Created by xiaomage on 16/7/2.
//  Copyright © 2016年 seemygo. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+ (UIImage *)imageNamedWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
