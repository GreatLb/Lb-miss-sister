//
//  LbAllViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/10.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LbAllViewController.h"
#import "LBThemeCell.h"
#import "LBThemeItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LBThemeViewModel.h"

static NSString *ID = @"cell";

#define LBURL @"http://api.budejie.com/api/api_open.php"

@interface LbAllViewController ()
@property(nonatomic, strong)NSMutableArray *themeViewMadelList;
@end

@implementation LbAllViewController

-(NSMutableArray *)themeViewMadelList{
    if(_themeViewMadelList == nil){
        _themeViewMadelList = [NSMutableArray array];
    }
    return _themeViewMadelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView  registerClass:[LBThemeCell class] forCellReuseIdentifier:ID];
    
    self.tableView.contentInset = UIEdgeInsetsMake(110, 0, 49, 0);
    
    self.tableView.backgroundColor = [UIColor yellowColor];
    [self loadData];
}


-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
//    parameters[@"type"] = @31;
    parameters[@"type"] = @(LBThemeTypeVoice);
    
    [mgr GET:LBURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        // 获取字典数组
        NSArray  *dictArray = responseObject[@"list"];
        // 字典数组转模型数组
        NSArray *themeList = [LBThemeItem mj_objectArrayWithKeyValuesArray:dictArray];
       // 模型数组转视图模型数组:面向谁开发,就转换成谁
        for (LBThemeItem *item in themeList) {
            // 创建视图模型
            LBThemeViewModel *vm = [[LBThemeViewModel alloc]init];
            // 视图模型,不但保存模型,也计算好了对应cell子控件位置和cell高度

            vm.item = item;
            [self.themeViewMadelList addObject:vm];
        }
        
        [self.tableView reloadData];
        
//      [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/Essence(精华)/Controller/theme.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themeViewMadelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LBThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.vm = _themeViewMadelList[indexPath.row];
    
    
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_themeViewMadelList[indexPath.row] cellH];
}



@end
