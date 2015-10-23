//
//  NSTimerViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "NSTimerViewController.h"


@interface NSTimerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) int number;

//NSTimer定义属性的时候千万不能用copy修饰, 不然直接崩溃
@property (nonatomic, weak) NSTimer *timer;



@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutArray = [NSMutableArray arrayWithObjects:@"公众号iOS开发：iOSDevTip",@"www.superqq.com",@"公众号iOS开发：iOSDevTip",@"www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip", nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.number = 0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 50)];
    label.text = [NSString stringWithFormat:@"%d",self.number];
    label.backgroundColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.label = label;
    
    
    /*             关于NSTimer的强引用
     
     Timer 添加到 Runloop 的时候，会被 Runloop 强引用
     Timer 又会有一个对 Target 的强引用（也就是 self ）, 也就是说 NSTimer 强引用了 self ，导致 self 一直不能被释放掉，所以也就走不到 self 的 dealloc 里。
     */
    
    
    
    /*                  线程
     NSTimer 在哪个线程创建就要在哪个线程停止，否则会导致资源不能被正确的释放。
     */
    
    
    /*                 dealloc
     
     那么问题来了：如果我就是想让这个 NSTimer 一直输出，直到 NSTimerAdvancedController 销毁了才停止，我该如何让它停止呢？
     
     1. NSTimer 被 Runloop 强引用了，如果要释放就要调用 invalidate 方法。
     2. 但是我想在 NSTimerAdvancedController 的 dealloc 里调用 invalidate 方法，但是 self 被 NSTimer 强引用了。
     3. 所以我还是要释放 NSTimer 先，然而不调用 invalidate 方法就不能释放它。
     4. 然而你不进入到 dealloc 方法里我又不能调用 invalidate 方法。
     
     
     综上所述: 也就是说要在销毁之前将计时器失效
     
*/
    
   
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
    
    //NSTimer默认运行在default mode下，default mode几乎包括所有输入源(除NSConnection) NSDefaultRunLoopMode模式。
    //actionTimer方法会每隔1s中被调用一次。NSTimer使用起来是不是非常简单。这是NSTimer比较初级的应用。
    
    
    
    /*                  当主界面被滑动时NSTimer失效了
     
    主界面被滑动是什么意思呢？就是说主界面有UITableView或者UIScrollView，滑动UITableView或者UIScrollView。这个时候NSTimer失效了。
    */
 
    
    
    
    
    /*         解决办法:            run loop
    解决方法就是将其加入到UITrackingRunLoopMode模式或NSRunLoopCommonModes模式中。
    NSRunLoopCommonModes：是一个模式集合，当绑定一个事件源到这个模式集合的时候就相当于绑定到了集合内的每一个模式。
    我理解的这句话的意思就是当绑定到这个循环集合的时候, 里面不管在做什么事情都会执行这个方法
     
     */
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];//这句代码一注销就会导致滑动的时候计时器失效
    
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //加上上面这两句代码之后滑动的时候计时器就不会失效
    
    
    
    
    UIButton *backBut = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(label.frame) + 30, kScreenWidth - 100, 50)];
    backBut.backgroundColor = [UIColor orangeColor];
    [backBut setTitle:@"点击之后添加返回按钮" forState:UIControlStateNormal];
    [self.view addSubview:backBut];
    [backBut addTarget:self action:@selector(addBackButton) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - 启动计时器

- (void)actionTimer:(NSTimer *)timer
{
    self.number++;
    self.label.text = [NSString stringWithFormat:@"%d",self.number];
    NSLog(@"%d",self.number);
}




#pragma mark - 第一种方法
- (void)viewWillDisappear:(BOOL)animated{
    
    //因为计时器对它的target是强引用, 所以如果视图消失的时候如果未把计时器失效, 就会导致视图对象还被计时器持有一份, 也就是说视图消失了但是不走dealloc方法
    
    //所以, 在视图将要消失的时候让计时器失效. 然后controller就会正常被销毁
    [self.timer invalidate];
    
}



#pragma mark - 第二种方法
- (void)addBackButton{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(invalidateTimerAndBackToFirstPage)];
}

- (void)invalidateTimerAndBackToFirstPage{
    
    //让计时器失效
    [self.timer invalidate];
    
    //将视图管理器推出栈
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUserSelect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.mutArray[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"计时器已失效, 视图已销毁");
}



@end
