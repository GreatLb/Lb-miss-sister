//
//  LBThemeTopView.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBThemeTopView.h"
#import <UIImageView+WebCache.h>
#import "LBThemeItem.h"

@interface  LBThemeTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UILabel *textView;

@end

@implementation LBThemeTopView

- (IBAction)moreButtonClick:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
   
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了收藏");
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了删除");
    }];
    [alertVC addAction:action];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
//    [[UIApplication sharedApplication].keyWindow.rootViewController  presentationController:alert  animated:YES  completion: nil];
    [[UIApplication  sharedApplication].keyWindow.rootViewController  presentViewController:alertVC animated:YES completion:nil];
}

-(void)setItem:(LBThemeItem *)item{
    
    [super setItem:item];
    //头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
    //姓名
    _nameView.text = item.name;
    //文本
    _textView.text = item.text;
    //时间
    
    NSString *strDate = [NSString stringWithString:item.created_at];
 
//    NSString *strDate = item.created_at;
  
    //获取日期格式化对象
    NSDateFormatter *fmt = [[NSDateFormatter  alloc]init];
    //字符串 转NSDate
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //获取发布日期
    NSDate *createDate = [fmt dateFromString:strDate];
    NSDateComponents *cmp = [createDate deltaWithNow];
    if ([createDate isThisYear]){
        if([createDate isToday]){
            if(cmp.hour > 1){
                strDate =[NSString stringWithFormat:@"%ld小时之前",(long)cmp.hour];
            }else if(cmp.minute > 1){
                strDate =[NSString stringWithFormat:@"%ld分钟之前",(long)cmp.minute];
            }else{
                strDate =@"刚刚";
            }
        }else if([createDate isYesterday]){
            fmt.dateFormat =@"昨天 HH:mm:ss";
            strDate =[fmt stringFromDate:createDate];
        }else {  //昨天之前
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            strDate = [fmt stringFromDate:createDate];
        }
    }
    _dateView.text = strDate;

  
    
    
}




/*
- (NSString *)timerStr
{
    NSString *timerStr = self.item.created_at;
    
    // 把发布字符串 => 发布日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 发布时间  item.created_at(2015-08-31 11:52:01)
    NSDate *createDate = [fmt dateFromString:timerStr];
    
    // 获取与当前时间差值
    NSDateComponents *cmp = [createDate deltaWithNow];
    
    // 今年:判断年份是否相等
    if ([createDate isThisYear]) {
        
        if ([createDate isToday]) { // 判断下是否今天
            
            if (cmp.hour >= 1 ) {
                timerStr = [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            } else if (cmp.minute > 1) {
                timerStr = [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            } else { // 刚刚
                timerStr = @"刚刚";
            }
            
        } else if ([createDate isYesterday]) { // 昨天 昨天 06:06
            fmt.dateFormat = @"昨天 HH:mm";
            timerStr = [fmt stringFromDate:createDate];
            
        } else { // 昨天之前
            // 07-12 06:06:06
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            timerStr = [fmt stringFromDate:createDate];
        }
    }
    return timerStr;
}

*/

@end
