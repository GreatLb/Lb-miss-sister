//
//  LBFileManger.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/10.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBFileManger.h"

@implementation LBFileManger
// 主线程中获取文件夹尺寸 => 可能比较耗时 => 开启异步线程,去获取文件夹尺寸
// 异步任务,不要返回值
// 获取文件夹尺寸 => 文件管理者 => 分类

+(void)getSizeOfDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;
{
    
    //获取NSFileManager 对象
    NSFileManager *mgr =[NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist =[mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory ];
    if(!isExist || !isDirectory){
        //报错,让外界知道
        NSException *excp =[NSException  exceptionWithName:@"FileEror" reason:@"路径错误,必须是存在的文件夹" userInfo:nil];
        [excp raise];  //抛出错误
        
    }

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获取文件夹里面所有文件
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        //文件大小初始值
        NSInteger totalSize = 0;
        //遍历所有文件
        for (NSString *fileName  in subPaths) {
            //拼接文件全路径
            NSString *filePath =[directoryPath  stringByAppendingPathComponent:fileName];
            //判断是否是隐藏文件或是文件夹
            if([fileName  hasPrefix:@"."]) continue ;//隐藏文件
            BOOL isDirectory;
            [mgr fileExistsAtPath:filePath isDirectory:&isDirectory ];
            if (isDirectory)  continue;//文件夹
            //获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            //叠加文件尺寸
            totalSize += [attr  fileSize];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completion){
                completion(totalSize);
            }
          });
});

}

+(void)deleteOfFilePath:(NSString *)filePath{

   //清楚缓存
  // 1 删除文件夹
  [[NSFileManager  defaultManager ] removeItemAtPath:filePath error:nil];
  //2 创建文件夹
   [[NSFileManager  defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
                       
 }
@end
