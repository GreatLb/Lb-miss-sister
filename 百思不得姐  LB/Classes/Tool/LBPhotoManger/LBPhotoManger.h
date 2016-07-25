//
//  LBPhotoManger.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/17.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
管理系统相册
*/
@interface LBPhotoManger : NSObject
+(void)savePhoto:(UIImage *)image  albumTitle:(NSString *)albumTitle   completionHandler:(void(^)(BOOL success,NSError *error))completionHandler;


+(PHAssetCollection *)fetchAlbumOfTitle :(NSString *)abeumTitle;
@end
