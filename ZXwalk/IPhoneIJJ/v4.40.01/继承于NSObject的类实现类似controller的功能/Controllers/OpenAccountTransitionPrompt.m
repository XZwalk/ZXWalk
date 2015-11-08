//
//  LoginTransitionSever.m
//  IphoneIJiJin
//
//  Created by ttyy on 15/10/21.
//
//

#import "OpenAccountTransitionPrompt.h"
#import "OpenAccountTransitionView.h"
#import "STModal.h"

@interface OpenAccountTransitionPrompt ()

@property (nonatomic, strong) STModal *tool;

@property (strong, nonatomic) IBOutlet OpenAccountTransitionView *baseView;


@end

@implementation OpenAccountTransitionPrompt

- (id)init {
    self = [super init];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"OpenAccountTransitionPrompt" owner:self
                                    options:nil];
    }
    return self;
}


- (void)show {
    
    self.tool.hideWhenTouchOutside = YES;
    self.tool.dimBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    [self.tool show:YES];
    
}


#pragma mark - private api

//负责样式的设置
- (void)setTransitionViewStyle {
    
    if (IS_IOS7) {
        
        NSDictionary *dic = @{NSFontAttributeName : FONT(15)};

        CGRect rect1 = [self.baseView.contentLabel1.text boundingRectWithSize:CGSizeMake(self.baseView.contentLabel1.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        CGRect rect2 = [self.baseView.contentLabel2.text boundingRectWithSize:CGSizeMake(self.baseView.contentLabel2.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        CGRect rect3 = [self.baseView.contentLabel3.text boundingRectWithSize:CGSizeMake(self.baseView.contentLabel3.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        self.baseView.frame = CGRectMake(0, 0,kSCREEN_WIDTH - 56, 290 + rect1.size.height + rect2.size.height + rect3.size.height);
    } else {
        
        CGSize size1 = [self.baseView.contentLabel1.text sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(self.baseView.contentLabel1.frame.size.width, 15)];
        
        CGSize size2 = [self.baseView.contentLabel2.text sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(self.baseView.contentLabel2.frame.size.width, 15)];
        
        
        CGSize size3 = [self.baseView.contentLabel3.text sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(self.baseView.contentLabel3.frame.size.width, 15)];
        
        self.baseView.frame = CGRectMake(0, 0,kSCREEN_WIDTH - 56, 290 + size1.height + size2.height + size3.height);
    }
    
    //因为xib中超出边界的图片显示有问题(超出部分无法显示), 故此处直接创建
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"openTransition_gold.png"]];
    
    [self.baseView addSubview:topImage];
    
    topImage.frame = CGRectMake(self.baseView.center.x - 28, - 28, 56, 56);
    
    NSAttributedString *openStr = [[NSAttributedString alloc] initWithString:@"10s快速开户" attributes:@{NSFontAttributeName : FONT(17), NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.baseView.openAccountBtn setAttributedTitle:openStr forState:UIControlStateNormal];

    NSAttributedString *loginStr = [[NSAttributedString alloc] initWithString:@"已有账户 立即登录" attributes:@{NSFontAttributeName : FONT(17), NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.baseView.loginBtn setAttributedTitle:loginStr forState:UIControlStateNormal];
}


//负责视图信息的显示
- (void)setTransitionViewInfo {
    
    NSDictionary *transitionData = nil;
    
    if (!transitionData) {
        self.baseView.titleLabel.text = @"现在加入爱基金";
        self.baseView.contentLabel1.text = @"立享新人神秘礼包";
        self.baseView.contentLabel2.text = @"买基金手续费最低2折";
        self.baseView.contentLabel3.text = @"高手一对一投资";
        
    } else {
        self.baseView.titleLabel.text = transitionData[@"title"];
        self.baseView.contentLabel1.text = transitionData[@"info1"];
        self.baseView.contentLabel2.text = transitionData[@"info2"];
        self.baseView.contentLabel3.text = transitionData[@"info3"];
    }
}

#pragma mark - event response
- (IBAction)openAccountAction {
    
    [self.tool hide:YES];
    
}



- (IBAction)loginAction {
    
    [self.tool hide:YES];
    
}

- (BOOL)checkIsLoginBefore {
    NSDictionary *dataDic = nil;
    if (dataDic) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - view kind of property setter and getter
- (STModal *)tool {
    if (!_tool) {
        self.tool = [STModal modalWithContentView:self.baseView];
        
        //先设置显示文本
        [self setTransitionViewInfo];
        
        //设置样式(字体颜色,大小设置在xib中)
        [self setTransitionViewStyle];
        
    }
    return _tool;
}

@end
