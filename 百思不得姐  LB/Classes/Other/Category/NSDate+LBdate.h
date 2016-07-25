//
//  NSDate+LBdate.h
//  百思不得姐  LB
//
//  Created by xmg on 16/7/16.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LBdate)
-(BOOL)isToday;
-(BOOL)isThisYear;
-(BOOL)isYesterday;
-(NSDateComponents *)deltaWithNow;

@end
