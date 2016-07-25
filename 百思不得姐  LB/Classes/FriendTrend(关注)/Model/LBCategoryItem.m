//
//  LBCategoryItem.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/18.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBCategoryItem.h"
#import <MJExtension/MJExtension.h>
@implementation LBCategoryItem
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
