//
//  LBBaseThemeViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/25.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBBaseThemeViewController.h"
#import "LbAllViewController.h"
#import "LBThemeCell.h"
#import "LBThemeItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LBThemeViewModel.h"
#import "LBFootRefreshView.h"
#import "LbHeaderRefershView.h"
#import "LBEssenceViewController.h"

static NSString *ID = @"cell";

@interface LBBaseThemeViewController ()
@property(nonatomic, strong)NSMutableArray *themeViewMadelList;
@property(nonatomic, weak)LBFootRefreshView *footView;
@property(nonatomic, weak)LbHeaderRefershView *headerView;
@property (nonatomic, assign) UIEdgeInsets oriInsets;
@property (nonatomic, assign) NSInteger maxtime;
@property(nonatomic, strong)AFHTTPSessionManager *mgr;
@property(nonatomic,assign)NSInteger offsetY;
@end

@implementation LBBaseThemeViewController

//重复点击标题按钮时会来调用
-(void)reload{
    
    // 在屏幕上,才需要下拉刷新
    // 如果一个view能拿到窗口,表示这个view显示窗口上
    
    if (self.view.window) {
        _headerView.alpha = 0 ;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.contentOffset = CGPointMake(0, -64);
            
            [self loadData];
        }];

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
    _oriInsets = self.tableView.contentInset;
    //取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //加载数据
    [self loadData];
//    // 监听tabBar重复点击通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"repeatClickTitle" object:nil];

    //添加上拉刷新
    [self setUpFootRefreshView];
    //添加下拉刷新
    [self setUpHeadRefreshView];
    
    //监听TabBar 重复点击通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(reload) name:@"repeatClickTitle" object:nil];
    }
//销毁通知
-(void)dealloc{
    [[NSNotificationCenter  defaultCenter]  removeObserver:self];
}

//下拉控件
-(void)setUpFootRefreshView{
    LBFootRefreshView *footView = [LBFootRefreshView footRefreshView];
    self.tableView.tableFooterView = footView;
    footView.hidden = YES;
    _footView = footView;
}
//上拉控件
-(void)setUpHeadRefreshView{
    LbHeaderRefershView  * headerView = [LbHeaderRefershView  headerRefershView];
    headerView.lb_y = -headerView.lb_height;
    self.tableView.tableHeaderView = headerView;
    _headerView = headerView;
    if(_offsetY == 0){
        _headerView.alpha = 0 ;
    }
    
    //刷新数据
    // 上拉控件,完全显示的时候,才需要刷新数据
    // 当用户拖动的时候,判断下上拉控件什么时候完全显示
    
}


//停止拖拽时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = self.tableView.contentOffset.y;
    _offsetY = offsetY;
//    NSLog(@"%f",offsetY);
    // 判断是否下拉控件完全显示
    if (offsetY <= -( self.tableView.contentInset.top + _headerView.lb_height)){
        
        
        // 当前正在刷新,就不需要刷新
        if(_headerView.isRefreshing == YES) return ;
        // 让下拉控件悬停:顶部在添加额外滚动区域
        UIEdgeInsets  inSets = self.tableView.contentInset;
        
        inSets.top += _headerView.lb_height;
        
        self.tableView.contentInset = inSets;
        
        [self loadData];
        
        _headerView.isRefreshing = YES;
        
    }
}

//只要拖拽就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理上拉控件
    [self dealFootView];
    if (self.tableView.contentOffset.y >= -64){
        _headerView.alpha
        = 0;
        
    }else{
        //0.2秒后显示下拉刷新
        [UIView animateWithDuration:0.2 animations:^{
            
            _headerView.alpha
            = 1;
        }];
        
    }
    //处理下拉控件
    [self dealHeaderView];
    
}

//处理上拉刷新
-(void)dealFootView{
    //如果没有数据就返回
    if (self.themeViewMadelList.count == 0) return;
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    //判断什么时间显示刷新
    if (offsetY >= self.tableView.contentSize.height + self.tableView.contentInset.bottom - LBScreenH){
        //如果正在刷新就返回,如果没有 就执行下面
        if (_footView.isRefreshing) return ;
        //加载更多数据
        [self loadMoreData];
        //刷新完后,让他的状态处于刷新, 下次不会再来
        _footView.isRefreshing = YES;
    }
    
}

//处理下拉刷新
-(void)dealHeaderView{
    //如果没有数据直接返回
    if (self.themeViewMadelList.count == 0) return;
    
    // 拖拽是的偏移量 //
    CGFloat offsetY = self.tableView.contentOffset.y; //-110
    //如果拖拽的偏移量小于等于'顶部内边距和头部视图的侯高的和' 判断头部视图的装填,处理事件
    if(offsetY <= -(self.tableView.contentInset.top + _headerView.lb_height)){
        //根据状态不同处理.展示事件
        _headerView.isVisable = YES;
        
    }else{
        _headerView.isVisable = NO;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //停止滚动后0.1 隐藏下拉刷新
    [UIView animateWithDuration:0.1 animations:^{
        
        _headerView.alpha
        = 0;
    }];
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
        
        [UIView animateWithDuration:0.2 animations:^{
            //恢复内边距,取消悬停效果
            self.tableView.contentInset = _oriInsets;
        }];
        //显示上拉控件
        _footView.hidden = NO;
        //让下拉刷新状态
        _headerView.isRefreshing = NO;
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
        //更新上拉刷新状态
        _footView.isRefreshing = NO;
        
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
