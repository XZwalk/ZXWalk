//
//  XZPlaceholderTextView.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "XZPlaceholderTextView.h"


@interface XZPlaceholderTextView ()

@end

@implementation XZPlaceholderTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.text = placeholder;
    self.textColor = [UIColor grayColor];
}

-(void)addObserver
{
    
    //自己不能做自己的代理, 代理存下的目的就是让其他人帮自己实现
    //我在遵守协议并指定自己为自己的代理, 并实现方法之后发现它并不走协议的方法
    //self.delegate = self;

    
    //所以, 如果想在view里面走代理的方法就可以采用下面的方法
    //注册通知
    //注册开始编辑时的通知, 当开始编辑时self会通知self走 didBeginEditing: 方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    //注册编辑结束时的通知, 当编辑结束时self会通知self走 didEndEditing: 方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    //注册程序挂掉时的通知, 当程序挂掉的时候程序会通知self走 terminate: 方法(移除通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminate:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
    
    
    /*
     
     第一个参数: 监听者
     第二个参数: 收到消息后执行的方法
     第三个参数: 消息的名字, 如果我这个名字不写, 那么只要有消息发送, 不管什么样的消息, 监听者都会执行方法
     第四个参数: 接收谁的消息, 如果这个置为nil, 那么只要有人发送消息, 监听者都会执行方法
     
     */
    
    
    
    
   }


- (void)terminate:(NSNotification *)notification {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didBeginEditing:(NSNotification *)notification {
    if ([self.text isEqualToString:self.placeholder]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
}

- (void)didEndEditing:(NSNotification *)notification {
    if (self.text.length<1) {
        self.text = self.placeholder;
        self.textColor = [UIColor grayColor];
    }
}

@end
