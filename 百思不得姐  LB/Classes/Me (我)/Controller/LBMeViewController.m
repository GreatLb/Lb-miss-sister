//
//  LBMeViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/3.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBMeViewController.h"
#import "LBSettingViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SafariServices/SafariServices.h>
#import "LBCollectionViewCell.h"
#import "LBMeSquareItem.h"
#import "LBWebViewController.h"

#define itemWh ((LBScreenW -(cols - 1)*margin)/cols)
#define  LBMEUrl @"http://api.budejie.com/api/api_open.php"

static NSString *const ID = @"cell";
static CGFloat margin = 1;
static NSInteger cols = 4;


@interface LBMeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>

@property(nonatomic, strong)NSMutableArray *squareItems;
@property(nonatomic, weak)UICollectionView *collectionView;

@end

@implementation LBMeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor grayColor];
    
    [self setupNavigationBar];
    
    [self setFootView];
    
    [self  contentInset];//从新设置内边距
    
    [self  loadData];
    
}

-(void)contentInset{
    // 处理cell之间间距
    // 默认group样式tableView,每一组自带组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    // 分组样式下tableView第0个cell默认有y值 35
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
//创建底部视图
-(void)setFootView{
    
    UICollectionViewFlowLayout *layout =({
        
        layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize =CGSizeMake(itemWh, itemWh);
        
        layout.minimumLineSpacing = margin;
        
        layout.minimumInteritemSpacing = margin;
        layout;
    });
    
    UICollectionView *collectionView =({
        
        collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
        
        collectionView.backgroundColor =[UIColor clearColor];
        
        // 设置数据源.展示cell
        collectionView.dataSource =self;
        collectionView.delegate =self;
        
        // 注册cell
        [collectionView registerNib:[UINib nibWithNibName:@"LBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
        
        collectionView;
    });
    _collectionView = collectionView;
    
    self.tableView.tableFooterView =collectionView;
    
}


-(void)setupNavigationBar{
    
    self.navigationItem.title=@"我的";
    
    UIBarButtonItem *setting =[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    UIBarButtonItem *night= [UIBarButtonItem  itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage  imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightBtnClick:)];
    
    self.navigationItem.rightBarButtonItems =@[setting,night];
}

//设置按钮点击
-(void)settingClick{
    
    LBSettingViewController  *settingVC = [[LBSettingViewController  alloc]init];
    
    settingVC.hidesBottomBarWhenPushed =YES;
    
    [self.navigationController  pushViewController:settingVC animated:YES];
}
//夜间模式按钮点击
-(void)nightBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;//取反
}
-(void)loadData{
    //创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:LBMEUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //获取字典数组
        NSArray *dictAray = responseObject[@"square_list"];
        
        //字典数组转模型数组
        _squareItems =[LBMeSquareItem  mj_objectArrayWithKeyValuesArray:dictAray];
        
        // 计算总行数 = (count - 1) / cols + 1
        NSInteger  rows = (_squareItems.count -1) /cols +1;
        
        // 计算下collectionView高度 = 总行数 * itemWh
        CGFloat collectionViewH =rows *itemWh + (rows -1) *margin;
        _collectionView.lb_height =collectionViewH;
       
        // bug:tableView不能滚动
        // 设置tableView滚动范围
        // tableView滚动范围由tableView自己管理,会根据自己的内容去自动计算
        self.tableView.tableFooterView =_collectionView;
        [_collectionView reloadData];
        
        [responseObject  writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/Me (我)/me.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
//点击cell 调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LBMeSquareItem * item = _squareItems[indexPath.row];
    if(![item.url  containsString:@"http"]) return; //路径中不包含  http  就返回
    //只要ios9
//    SFSafariViewController *SafariVc =[[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:item.url]];
    LBWebViewController *webVC = [[LBWebViewController alloc]init];
    webVC.url =[NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _squareItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LBCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = _squareItems[indexPath.row];
    return  cell;
}


@end
