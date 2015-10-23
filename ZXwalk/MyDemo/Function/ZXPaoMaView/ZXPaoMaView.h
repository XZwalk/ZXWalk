//
//  ZXPaoMaView.h
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXPaoMaView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;

- (void)start;//开始跑马
- (void)stop;//停止跑马

@end
