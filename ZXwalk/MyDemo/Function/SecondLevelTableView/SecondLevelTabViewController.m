//
//  RootViewController.m
//  SharedTwoTableVew
//
//  Created by laouhn on 15/8/6.
//  Copyright (c) 2015年 吕桂峰. All rights reserved.
//

#import "SecondLevelTabViewController.h"
#import "CarModel.h"
#import "AFNetworking.h"
@interface SecondLevelTabViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain)NSMutableArray * categoryAry; // 参数配置的类别 即leftTableView数据源
@property (nonatomic, retain)NSMutableArray * valueAry;    // 参数类别的详细信息即 rightTableView 数据源
@property (nonatomic, retain)UITableView    * leftTableView;
@property (nonatomic, retain)UITableView    * rightTableView;
@end

@implementation SecondLevelTabViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详细参数";
    self.view.backgroundColor   = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
    //添加到视图上
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self getParamterData];
}

#pragma mark - 懒加载
- (UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 125, [UIScreen mainScreen].bounds.size.height -64 ) style:UITableViewStyleGrouped] ;
        
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        [self.leftTableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    }
    
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (_rightTableView == nil) {
        self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(127, 64, [UIScreen mainScreen].bounds.size.width - 127, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain] ;
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        
        [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    }
    
    return _rightTableView;
}


- (NSMutableArray *)categoryAry{
    if (_categoryAry == nil) {
        self.categoryAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _categoryAry;
    
}

- (NSMutableArray *)valueAry
{
    if (_valueAry == nil) {
        self.valueAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _valueAry ;
}


#pragma mark - 网络解析
- (void)getParamterData
{
    AFHTTPRequestOperationManager   * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
       [manager GET:@"http://app.autostreets.com/replacement/getParamterData?modelSid=11882" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"data"] count] ) {
            [self parserDataWithDic:responseObject ];
        }else
        {
            [self alertViewShowWithMessage:@"暂时没有详细参数"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self alertViewShowWithMessage:@"网络解析错误"];
        
    }];
}




- (void)parserDataWithDic:(NSDictionary *)dic
{
   
    if ([dic[@"data"] count]) {
        for (NSDictionary * aDic in dic[@"data"]) {
            
            CarModel  * model= [[CarModel alloc]init];
            [model setValuesForKeysWithDictionary:aDic];
            //将model中的参数类别添加到categoryAry
            [self.categoryAry addObject:[model valueForKey:@"category"]];
            //将model中的参数类别的详细信息添加到 valueAry，每一个详细信息是一个数组即valueAry中存储的时好多个数组
            [self.valueAry addObject:[model valueForKey:@"parametersVo"]];
        }
        
        //刷新两个表
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
    }
    
    
}


#pragma mark - 警告视图

- (void)alertViewShowWithMessage:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}



#pragma mark - tableView代理的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果是左边的tableView
    if ([tableView isEqual:_leftTableView]) {
        return self.categoryAry.count ;
    }else
    {
        //否则是右边的
        return [[self.valueAry objectAtIndex:section] count];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //如果是左边的tableView
    if ([tableView isEqual:_leftTableView]) {
        return 1;
    }else
    {   //否则是右边的
        return self.categoryAry.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //如果是左边的tableView
    if ([tableView isEqual:_leftTableView]) {
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell1.textLabel.text = self.categoryAry[indexPath.row];
        cell1.textLabel.textAlignment = NSTextAlignmentLeft;
        cell1.textLabel.font = [UIFont systemFontOfSize:13];
        return cell1;
    }else
    {
        //否则是右边的
        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        cell2.textLabel.text  = [[[self.valueAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell2.textLabel.font = [UIFont systemFontOfSize:13];
        cell2.detailTextLabel.text = [[[self.valueAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]
                                      objectForKey:@"value"];
        cell2.detailTextLabel.font = [UIFont systemFontOfSize:13];
        return cell2;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //因为rightTableView 点击cell的时候没有效果，因此只对leftTableView的cell点击进行处理
    if ([tableView isEqual:_leftTableView]) {
        //当点击左边的tableView的时候需要使右边的tableView滚动到对应的区，左边tableView的行号是右边tableView的区号
        NSIndexPath * index = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
        [_rightTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

// 将要显示某一区 的区头时
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([tableView isEqual:_rightTableView]) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:section inSection:0];

        // 滚动到某一行，并选中
        [_leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    
}


//设置区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_rightTableView]) {
        return self.categoryAry[section];
    }else
    {
        return nil;
    }
}



//设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_rightTableView]) {
        return 40;
    }
    return 10;
}



//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTableView]) {
        return 40.0f;
    }
    return 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
