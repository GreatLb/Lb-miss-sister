//
//  LBSettingViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/5.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBSettingViewController.h"
#import <SDImageCache.h>
#import "LBFileManger.h"
#import <SVProgressHUD.h>

#define LBcachePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]

@interface LBSettingViewController ()

@property(nonatomic, assign) NSInteger totalSize;

@end

static  NSString *  const ID = @"cell";

@implementation LBSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self  setBackButton];
}

-(void)setBackButton{
    self.title =@"设置";
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    NSString *cachePath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸"];
    
    [LBFileManger getSizeOfDirectoryPath:cachePath completion:^(NSInteger totalSize) {
        
        [SVProgressHUD dismiss];
        
        _totalSize =totalSize;
        //刷新数据
        [self.tableView reloadData];
    }];
    

    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

/*
 如何获取文件夹尺寸
 1.获取NSFileManager对象
 
 2.获取文件夹里面所有文件
 3.遍历文件夹里所有文件
 4.拼接文件全路径
 5.attributesOfItemAtPath:指定一个文件全路径,就能获取文件属性
 6.获取文件尺寸 叠加起来
 */
//-(NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath{
//    //获取NSFileManager 对象
//    NSFileManager *mgr =[NSFileManager defaultManager];
//    //获取文件夹里面所有文件
//    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
//    //文件大小初始值
//    NSInteger totalSize = 0;
//    //遍历所有文件
//    for (NSString *fileName  in subPaths) {
//        //拼接文件全路径
//        NSString *filePath =[directoryPath  stringByAppendingPathComponent:fileName];
//        //判断是否是隐藏文件或是文件夹
//        if([fileName  hasPrefix:@"."]) continue ;//隐藏文件
//        BOOL isDirectory;
//        [mgr fileExistsAtPath:filePath isDirectory:&isDirectory ];
//        if (isDirectory)  continue;//文件夹
//        //获取文件属性
//        NSDictionary *attr = [mgr  attributesOfItemAtPath:filePath error:nil];
//        //叠加文件尺寸
//        totalSize += [attr  fileSize];
//        NSLog(@"%ld",totalSize);
//        
//    }
//    return totalSize;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
        cell.textLabel.text = [self getSizeStr:_totalSize];
    return cell;
}
-(NSString *)getSizeStr:(NSInteger *)totalSize{
    CGFloat  totalSizeF = 0;
    
    //计算缓存尺寸(谁做了缓存,SDWebImage,WKWebView)
    //获取SDWebImage
    //   NSUInteger *fileSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *sizeStr  = @"清理缓存";
    if(_totalSize > 1000 * 1000){
        totalSizeF = _totalSize/(1000.0 * 1000.0)
        ;
        sizeStr = [NSString  stringWithFormat:@"%@(%.1fMB)",sizeStr,totalSizeF];
        
    }else if(_totalSize >  1000){
        totalSizeF = _totalSize/ 1000.0;
        ;
        sizeStr = [NSString  stringWithFormat:@"%@(%.1fKB)",sizeStr,totalSizeF];
    }else if(_totalSize >  0){
        sizeStr = [NSString  stringWithFormat:@"%@(%ldB)",sizeStr,_totalSize];
    }
    sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    // 缓存尺寸
     return sizeStr;
}
//点击cell 调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //清楚缓存
    [LBFileManger deleteOfFilePath:LBcachePath];
    
    //3 刷新呢表格
    _totalSize = 0;
    [self.tableView reloadData];
}

@end
