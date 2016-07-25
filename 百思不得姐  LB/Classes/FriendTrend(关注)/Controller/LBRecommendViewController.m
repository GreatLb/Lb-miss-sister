//
//  LBRecommendViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/17.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBRecommendViewController.h"
#import "LBCategoryCell.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LBCategoryItem.h"
#import "LBSubTableViewCell.h"
#import "LBUserItem.h"
#import <MJRefresh/MJRefresh.h>

static NSString *userID = @"user";
static NSString *categoryID = @"category";

@interface LBRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property(strong, nonatomic)NSArray *categoryArrs;

//当前选中模型
@property(nonatomic, strong)LBCategoryItem *selectCategory;
@property(nonatomic,strong)AFHTTPSessionManager *mgr;

@end

@implementation LBRecommendViewController

-(AFHTTPSessionManager *)mgr{
    if(_mgr == nil){
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    //取消格外滚动区域  默认指挥给一个tablevIew 添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加额外滚动区域
    _categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //添加额外滚动区域
    _userTableView.contentInset =  _categoryTableView.contentInset;
    //从xib 加载cell
    [_userTableView registerNib:[UINib   nibWithNibName:@"LBSubTableViewCell" bundle:nil] forCellReuseIdentifier:userID];
    //从xib 加载cell
    [_categoryTableView registerNib:[UINib  nibWithNibName:@"LBCategoryCell" bundle:nil] forCellReuseIdentifier:categoryID];
    
    [self loadCategoryData];
    [self setUpRefreshView];
   }


-(void)setUpRefreshView{
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUserDate)];
    header.automaticallyChangeAlpha =YES;
    self.userTableView.mj_header = header;
    //上拉
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUseDate)];
    footer.automaticallyChangeAlpha = YES;
    self.userTableView.mj_footer = footer;
    
}
-(void)loadCategoryData{
    //创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    //发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSArray *dictArr = responseObject[@"list"];
        _categoryArrs = [LBCategoryItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        [_categoryTableView  reloadData];
        //选中第 0  个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        // 选中左边->分类tableView 第0个cell
        [_categoryTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        //主动加载cell   加载右边数据
        [self tableView:_categoryTableView didSelectRowAtIndexPath:indexPath];
//        [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/FriendTrend(关注)/category.plist" atomically:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
// 选中cell就会调用
// 用户手动点击cell就会调用,通过代码选中cell,不会调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _categoryTableView){
        _selectCategory = _categoryArrs[indexPath.row];
        //当推荐的用户组有数据时  再去加载
        if(_selectCategory.users.count){
            //当指定选中左侧那一行cell时  如果有数据  就去刷新加载对应的数据    如果没有数据就跳出if   继续执行
            [_userTableView reloadData];
            //刷新数据后,如果当前页数大于上次的页数  Yes 底部显示刷新
            self.userTableView.mj_footer.hidden = _selectCategory.page >= _selectCategory.total_page;
            return;
        }
        //当第一次点击cell时 没有用户数据就显示顶部刷新  加载用户数据
        //触发下拉刷新
        [self.userTableView.mj_header  beginRefreshing];
//        [self loadUserDate];
    }
}
//记载更多用户数据
-(void)loadMoreUseDate{
    // 没有更多数据,隐藏上拉刷新控件
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = _selectCategory.ID;
    parameters[@"page"]=@(_selectCategory.page);
    
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
       //页码++
        _selectCategory.page ++;
      //结束下拉刷新
        [self.userTableView.mj_footer endRefreshing];
        // 字典数组转模型数组
        // 请求到更多用户数据
        NSArray * users = [ LBUserItem mj_objectArrayWithKeyValuesArray:responseObject [@"list"]];
        
        // addObjectsFromArray:把数组中所有元素添加到上面
        [_selectCategory.users addObjectsFromArray:users];
        
        
        [_userTableView reloadData];
        
        
        self.userTableView.mj_footer.hidden = _selectCategory.page >= _selectCategory.total_page;
        
        //    [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/FriendTrend(关注)/user.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

-(void)loadUserDate{
    
    _selectCategory.page = 1;
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager  manager];
    [mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
//
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = _selectCategory.ID;
    
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        _selectCategory.page ++;
        //记录分类总页数
        _selectCategory.total_page = [responseObject[@"total_page"] integerValue];
        //结束下拉刷新
        [self.userTableView.mj_header  endRefreshing];
        _selectCategory.users = [ LBUserItem mj_objectArrayWithKeyValuesArray:responseObject [@"list"]];
        
        [_userTableView reloadData];
        // 必须要在reloadData后,隐藏上拉控件,
        self.userTableView.mj_footer.hidden = _selectCategory.page >= _selectCategory.total_page;

        
//    [responseObject writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/FriendTrend(关注)/user.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _categoryTableView){
        return _categoryArrs.count;    }
    else{
        return _selectCategory.users.count;
        }
}
-(UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (tableView == _categoryTableView){
        
        LBCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.item = _categoryArrs[indexPath.row];
        return cell;
    }
    
    LBSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
    cell.userItem = _selectCategory.users[indexPath.row];
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView ==_categoryTableView){
        return  44;
    }
    
    return  60;
}


@end
