//
//  LBVideoViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/10.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBVideoViewController.h"
static NSString *ID = @"cell";
@interface LBVideoViewController ()

@end

@implementation LBVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(110, 0, 49, 0);    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"视频 ---%ld",indexPath.row];
    
    
    return cell;
}




@end
