//
//  NSDate+LBdate.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/16.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "NSDate+LBdate.h"

@implementation NSDate (LBdate)

-(NSDateComponents *)deltaWithNow{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    
    //获取当前日历
    NSCalendar *calender = [NSCalendar currentCalendar];
   //获取时间差
    return [calender components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:currentDate options:NSCalendarWrapComponents];
}


-(BOOL)isThisYear{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calenter = [NSCalendar currentCalendar];
    
    NSDateComponents *curComp = [calenter components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *postComp = [calenter components:NSCalendarUnitYear fromDate:currentDate];
    return  curComp.year == postComp.year ;
    
}

-(BOOL)isToday{
    NSCalendar *current = [NSCalendar currentCalendar];
    return   [current isDateInToday:self];
   
}

-(BOOL)isYesterday{
    NSCalendar *current = [NSCalendar currentCalendar];
    return   [current isDateInYesterday:self];
}




@end
