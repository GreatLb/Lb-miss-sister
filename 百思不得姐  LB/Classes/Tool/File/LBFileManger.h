//
//  LBFileManger.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/10.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBFileManger : NSObject

+ (void)getSizeOfDirectoryPath:(NSString *)directoryPath completion:(void (^)(NSInteger totalSize))completion;


+(void)deleteOfFilePath:(NSString *)filePath;
@end
