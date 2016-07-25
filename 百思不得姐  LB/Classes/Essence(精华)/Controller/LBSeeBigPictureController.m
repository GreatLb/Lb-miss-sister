//
//  LBSeeBigPictureController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/17.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBSeeBigPictureController.h"
#import "LBThemeItem.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
#import "LBPhotoManger.h"
@interface  LBSeeBigPictureController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic) UIImageView *imageView;
@end

@implementation LBSeeBigPictureController


-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]init];
    
    _imageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_item.image0]];
    [_scrollView addSubview:imageView];
    
    CGFloat  w = LBScreenW;
    
    CGFloat  h = w / _item.width * _item.height;
    
    imageView.frame = CGRectMake(0, 0, w, h);
    
    if (!_item.is_bigPicture) {
        
        imageView.center = CGPointMake(LBScreenW * 0.5, LBScreenH * 0.5);
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:_item.image1]];
        _scrollView.contentSize =CGSizeMake(0, h);
    }
    _scrollView.delegate = self;
    
    if(_item.height / h > 1){
        
        _scrollView.maximumZoomScale = _item.height / h;
    }
    
    _scrollView.minimumZoomScale = 1;
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  _imageView;
}
- (IBAction)backButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClick:(id)sender {
    /**
     PHAuthorizationStatusNotDetermined : 不决定
     PHAuthorizationStatusRestricted :    手机被家长控制,不能修改状态  PHAuthorizationStatusDenied    :拒绝
     PHAuthorizationStatusAuthorized    :允许
     
     */
    
    switch ([PHPhotoLibrary authorizationStatus]){
        case PHAuthorizationStatusNotDetermined:
            //           case  PHAuthorizationStatusNotDetermined:
        {
            
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status  == PHAuthorizationStatusAuthorized){
                    [LBPhotoManger savePhoto:_imageView.image albumTitle:@"百思不得姐" completionHandler:^(BOOL success, NSError *error) {
                        
                        if (error){
                            [SVProgressHUD showErrorWithStatus:@"保存失败"];
                        }else {
                            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                        }
                        
                        
                    }];
                    
                }
            }];
            break;
        }
            
        case PHAuthorizationStatusAuthorized:
            
        {
            [LBPhotoManger savePhoto:_imageView.image albumTitle:@"百思不得姐" completionHandler:^(BOOL success, NSError *error) {
                
                if (error){
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                }
            }];
            
            break;
        }
        default:{
            
            [SVProgressHUD showInfoWithStatus:@"设置 -> 百思不得姐 -> 打开允许访问相册开关"];
        }
    };
    
    
    
    //    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//- (void)image:(UIImage *)image
//didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error){
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    }else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}

//搜索自定义相册
/*
 -(PHAssetCollection *)fetchAlbum{
 //获取系统所有相册
 PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
 //遍历系统相册
 for(PHAssetCollection *assetCollection in result){
 if([assetCollection.localizedTitle isEqualToString:@"百思不得姐 相册"]){
 return  assetCollection;
 }
 }
 return  nil;
 }
 
 
 //保存图片
 -(void)savePhoto{
 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
 // 判断下是否已经存在相册,如果已经存在相册,保存到之前相册
 // 遍历系统相册,查找之前相册
 PHAssetCollection *album = [self fetchAlbum];
 
 //创建相册请求类
 PHAssetCollectionChangeRequest  *assetCollectionChangeRequest;
 if(album){
 assetCollectionChangeRequest =  [PHAssetCollectionChangeRequest  changeRequestForAssetCollection:album];
 }else{
 assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"百思不得姐 相册"];
 }
 //发送图片请求了类
 PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest  creationRequestForAssetFromImage:_imageView.image];
 
 //添加图片到相册中
 //assetCreationRequest :   数组
 [assetCollectionChangeRequest  addAssets:@[assetCreationRequest.placeholderForCreatedAsset]];
 } completionHandler:^(BOOL success, NSError * _Nullable error) {
 if (error){
 [SVProgressHUD showErrorWithStatus:@"保存失败"];
 }else {
 [SVProgressHUD showSuccessWithStatus:@"保存成功"];
 }
 
 
 }];
 
 }
 */
@end
