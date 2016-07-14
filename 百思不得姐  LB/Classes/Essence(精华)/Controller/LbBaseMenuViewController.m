//
//  LbBaseMenuViewController.m
//  百思不得姐  LB
//
//  Created by xmg on 16/7/12.
//  Copyright © 2016年 LONGBO. All rights reserved.
//

#import "LbBaseMenuViewController.h"

static NSString * const ID = @"cell";

@interface LbBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, weak)UIScrollView *topView;
@property(nonatomic, weak)UICollectionView *bottomView;
@property(nonatomic, weak)UIButton *selectButton;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,weak)UIView *underLineView;
@property(nonatomic,assign)BOOL isInitail;

@end

@implementation LbBaseMenuViewController

-(NSMutableArray *)buttons{
    if( _buttons == nil){
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self setBottomView];
    [self setTopView];   //添加顶部 滚动标题View
    //取消格外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    if(_isInitail == NO){
        
    [self setUpAllTitleButton]; //添加按钮标题

        _isInitail = YES;
    }
}

-(void)setTopView{
    
    UIScrollView *topView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, LBScreenW, 44)];
    //    topView.backgroundColor =[UIColor blackColor];
    topView.backgroundColor = [UIColor colorWithRed:218.0/255   green:165.0/255     blue:10.0 /255  alpha:0.6];
    //    topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    [self.view addSubview:topView];
    _topView = topView;
}

-(void)setBottomView{
    
    UICollectionViewFlowLayout *layout = ({
        layout =[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize =CGSizeMake(LBScreenW, LBScreenH);
        //滚动方向
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        layout;
    });
    
    UICollectionView * collectionoView =({
        collectionoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LBScreenW, LBScreenH) collectionViewLayout:layout];
        collectionoView.backgroundColor = [UIColor greenColor];
        
        _bottomView = collectionoView;
        collectionoView.dataSource =self;
        collectionoView.delegate =self;
        //开启分页
        collectionoView.pagingEnabled = YES;
        [collectionoView registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:ID];
        collectionoView;
    });
    
    [self.view addSubview:collectionoView];
    
}

-(void)setUpAllTitleButton{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = LBScreenW / count;
    CGFloat btnH = 44;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i < count; i ++) {
        btnX = btnW * i;
        UIButton *btn =[UIButton buttonWithType:  UIButtonTypeCustom];
        btn.tag = i;
        UIViewController *vc =self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [_topView addSubview:btn];
        //添加到数组
        [self.buttons  addObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){ //默认选中第 0  个
            UIView *unLineView = [[UIView alloc]init];
            unLineView.backgroundColor = [UIColor redColor];
            [btn.titleLabel  sizeToFit];
            unLineView.lb_width = btn.titleLabel.lb_width;
            CGFloat h = 2;
            unLineView.lb_height = h;
            unLineView.lb_centerX = btn.lb_centerX;
            unLineView.lb_y = btn.lb_height - h;
            _underLineView = unLineView;
            [_topView addSubview:unLineView];
            [self btnClick:btn];
        }
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //移除之前子控制器View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *VC = self.childViewControllers[indexPath.row];
    VC.view.frame = CGRectMake(0, 0, LBScreenW, LBScreenH);
    //往contentView 添加子空间
    [cell.contentView addSubview:VC.view];
    
    return  cell;
}
-(void)setSelectButton:(UIButton *)button{
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    //移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        _underLineView.lb_centerX = button.lb_centerX;
    }];
}
//点击按钮时  切换视图
-(void)btnClick:(UIButton *)button{
    
    NSInteger i = button.tag;
    [self setSelectButton:button];
    CGFloat  offsetX = i * LBScreenW;
    _bottomView.contentOffset = CGPointMake(offsetX, 0);
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page =scrollView.contentOffset.x / LBScreenW;
    //获取按钮
    UIButton *button = self.buttons[page];
    //选中按钮
    [self setSelectButton:button];
    
}


@end
