//
//  LBSubTableViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/7.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LBSubTableViewController.h"
#import "LBSubTableViewCell.h"
#import  <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LBSubTagItem.h"
#import <SVProgressHUD.h>
static NSString *ID = @"cell";

@interface LBSubTableViewController ()
@property(nonatomic, strong)NSArray *itemArray;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation LBSubTableViewController
/*
 1.自定义分割线
 2.设置系统属性,让分割线占据全屏 iOS6和iOS7 iOS7和iOS8
 3.重写cell的setFrame 万能
 3.1 取消系统分割线
 3.2 设置tableView背景色为分割线颜色
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订阅标签";
    //注册Xib
    [self.tableView registerNib:[UINib nibWithNibName:@"LBSubTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [SVProgressHUD  showWithStatus:@"正在加载数据..."];
    //加载数据
    [self loadDate];
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor greenColor];
}


-(void)loadDate{
    //创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    //凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        //显示数据后,隐藏指示器
        [SVProgressHUD  dismiss];
        
        
        //字典数组 转模型数组
    _itemArray =[LBSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView  reloadData];
//    //生成plist  文件
//    [responseObject  writeToFile:@"/Users/xmg/Desktop/百思不得姐  LB/Lb-miss-sister/百思不得姐  LB/Classes/New(新帖)/sub.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [SVProgressHUD  dismiss];
    }];
    
}
//屏幕即将消失
-(void)viewWillDisappear:(BOOL)animated{
    //≈隐藏指示器
    [SVProgressHUD  dismiss];
    
    //取消请求
    [_mgr.tasks  makeObjectsPerformSelector:@selector(cancel)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LBSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = _itemArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60 + 10;//  设置分割线时  减了10  这里一定要补回去  不然会遮挡cell 的显示
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
