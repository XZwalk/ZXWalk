//
//  StandardViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/11/8.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "StandardViewController.h"

@interface StandardViewController ()

@end

@implementation StandardViewController



/*
 
 develop attention: please read each line blew carefully and do exactly what it says:
 to be good job with UIViewController begin with understanding the role of UIViewController below;
 
 
 1. View Managerment         (管理页面上显示的视图)
 2. Data Marshaling          (负责把可以直接显示的数据传给视图,注: 加工数据不是UIViewController的责任)
 3. User Interactions        (负责响应用户交互)
 4. Resource Managerment     (资源管理, 管理成员对象的生命周期, 当有内存警告时需要释放所有视图类的对象)
 5. Adaptivity               (对不同尺寸的设备在显示上作适配)
 
 */



#pragma mark - life cycle callback of UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.infoLabel.text = @"规范的视图控制器的写法,具体看代码";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - view kind of resource management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - event response
//button的事件响应等





#pragma mark - private api




#pragma mark - managing view layout
- (void)viewDidLayoutSubviews {
    
}



- (void)viewWillLayoutSubviews  {
    
}



#pragma mark - customDelegate





#pragma mark - view kind of property setter and getter

/*
 if you announce view kind of property like this: @property(nonatomic, retain) UIView *view;
 then you might implement getter method like below:
 
 
 - (UIView *)view {
 if (!_view) {
 self.view = [[UIView alloc] init];
 }
 return _view;
 }
 
 after you have implement menthed above
 
 please access this view kind of property like"self.view" rather than "_view"
 
 
 
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
