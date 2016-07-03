//
//  UIImage+Image.h
//  BuDeJie16
//
//  Created by xiaomage on 16/7/2.
//  Copyright © 2016年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 返回一个没有被渲染图片
+ (UIImage *)imageNamedWithOriginal:(NSString *)imageName;
@end
