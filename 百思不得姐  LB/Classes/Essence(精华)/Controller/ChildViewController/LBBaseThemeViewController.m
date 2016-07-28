//
//  LBBaseThemeViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/25.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBBaseThemeViewController.h"
#import "LBThemeCell.h"
#import "LBThemeItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LBThemeViewModel.h"
#import "LBEssenceViewController.h"
#import <MJRefresh/MJRefresh.h>

static NSString *ID = @"cell";

@interface LBBaseThemeViewController ()
@property(nonatomic, strong)NSMutableArray *themeViewMadelList;
@property (nonatomic, assign) NSInteger maxtime;
@property(nonatomic, strong)AFHTTPSessionManager *mgr;
@end

@implementation LBBaseThemeViewController

//重复点击标题按钮时会来调用
-(void)reload{
    
    // 在屏幕上,才需要下拉刷新
    // 如果一个view能拿到窗口,表示这个view显示窗口上
    
    if(self.view.window){
        //刷新数据
        [self.tableView.mj_header beginRefreshing];
        
        //[self loadData];
    }
}


//只创建一次 ,解决上下拉刷新冲突问题
-(AFHTTPSessionManager *)mgr{
    if(_mgr == nil){
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

-(NSMutableArray *)themeViewMadelList{
    if(_themeViewMadelList == nil){
        _themeViewMadelList = [NSMutableArray array];
    }
    return _themeViewMadelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView  registerClass:[LBThemeCell class] forCellReuseIdentifier:ID];
    //添加格外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
       //取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //加载数据
    [self loadData];

    [self setUprefreshView];
        }



-(void)setUprefreshView{
    //下拉
    MJRefreshNormalHeader  * headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    //自动隐藏下拉控件
    headerView.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = headerView;
    
    //上拉
    MJRefreshAutoNormalFooter *footView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //自动隐藏上拉控件
    footView.automaticallyHidden = YES;
    self.tableView.mj_footer = footView;
    
     //接收通知,监听标题按钮重复点击
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(reload) name:@"repeatClickTitle" object:nil];
}

//销毁通知对象
-(void)dealloc{
  
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)loadData{
    
    //AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //取消上拉请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    //凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //判断点击了精华还是新帖的标题按钮,加载不同的数据
    NSString *a = @"newList";  //默认加载新帖的数据
    //如果父类是精华控制器 就修改参数,加载对应的数据
    if([self.parentViewController  isKindOfClass:[LBEssenceViewController  class]]){
        a = @"list";
    }

    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    //发送请求
    [self.mgr GET:LBURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        //结束下拉刷新状态:一定要记得结束下拉刷新状态
        [self.tableView.mj_header endRefreshing];

        // 记录上一页最大maxtime
        _maxtime = [responseObject[@"info"][@"maxtime"] integerValue];
        
        // 获取字典数组
        NSArray  *dictArray = responseObject[@"list"];
        // 字典数组转模型数组
        NSArray *themeList = [LBThemeItem mj_objectArrayWithKeyValuesArray:dictArray];
        //删除之前所有数据
        [self.themeViewMadelList  removeAllObjects];
        
        // 模型数组转视图模型数组:面向谁开发,就转换成谁
        for (LBThemeItem *item in themeList) {
            // 创建视图模型
            LBThemeViewModel *vm = [[LBThemeViewModel alloc]init];
            // 视图模型,不但保存模型,也计算好了对应cell子控件位置和cell高度
            
            vm.item = item;
            //把模型保存到数组中
            [self.themeViewMadelList addObject:vm];
        }
        
        [self.tableView reloadData];
        
        [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/Essence(精华)/Controller/theme.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}


#pragma mark -加载更多数据
-(void)loadMoreData{
    //取消下拉请求
    // AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //判断是否是新帖
    NSString *a = @"newList";
    if([self.parentViewController  isKindOfClass:[LBEssenceViewController  class]]){
        a = @"list";
    }
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = @(_maxtime);
    
    [self.mgr GET:LBURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        //结束上拉刷新
        [self.tableView.mj_footer  endRefreshing];
        
        //记录上一页最大maxtime
        _maxtime = [responseObject[@"info"][@"maxtime"]integerValue];
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
            //添加新数据
            [self.themeViewMadelList addObject:vm];
        }
        //刷新表格
        [self.tableView reloadData];
        //生成Plist 文件
        [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/Essence(精华)/Controller/theme.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

//返回多少行cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themeViewMadelList.count;
}

//cell的样式即数据展示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LBThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.vm = _themeViewMadelList[indexPath.row];
    
    return cell;
}

//cell 的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_themeViewMadelList[indexPath.row] cellH]+ 10 ;
}


@end
