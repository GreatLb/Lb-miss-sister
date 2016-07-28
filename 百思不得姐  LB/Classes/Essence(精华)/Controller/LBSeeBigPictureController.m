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
   
    
}

@end
