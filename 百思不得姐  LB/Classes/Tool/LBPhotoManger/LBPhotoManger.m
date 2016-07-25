
//
//  LBPhotoManger.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/17.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBPhotoManger.h"

@implementation LBPhotoManger
+(void)savePhoto:(UIImage *)image  albumTitle:(NSString *)albumTitle   completionHandler:(void(^)(BOOL success,NSError *error))completionHandler{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 判断下是否已经存在相册,如果已经存在相册,保存到之前相册
        // 遍历系统相册,查找之前相册
        PHAssetCollection *album = [self  fetchAlbumOfTitle:albumTitle];
        
        //创建相册请求类
        PHAssetCollectionChangeRequest  *assetCollectionChangeRequest;
        if(album){
            assetCollectionChangeRequest =  [PHAssetCollectionChangeRequest  changeRequestForAssetCollection:album];
        }else{
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        //发送图片请求了类
        PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest  creationRequestForAssetFromImage:image];
        
        //添加图片到相册中
        //assetCreationRequest :   数组
        [assetCollectionChangeRequest  addAssets:@[assetCreationRequest.placeholderForCreatedAsset]];
    } completionHandler:completionHandler];

}


+(PHAssetCollection *)fetchAlbumOfTitle :(NSString *)abeumTitle{
    //获取系统所有相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //遍历系统相册
    for(PHAssetCollection *assetCollection in result){
        if([assetCollection.localizedTitle isEqualToString:abeumTitle]){
            return  assetCollection;
        }
    }
    return  nil;
}
     


@end
