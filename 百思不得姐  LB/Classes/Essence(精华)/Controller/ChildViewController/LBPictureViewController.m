//
//  LBPictureViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/10.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBPictureViewController.h"
static NSString *ID = @"cell";

@interface LBPictureViewController ()

@end

@implementation LBPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(110, 0, 49, 0);    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 18;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"图片----%ld",indexPath.row];
    
    return cell;
}



@end
