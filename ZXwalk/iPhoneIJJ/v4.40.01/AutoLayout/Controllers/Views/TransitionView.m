//
//  TransitionView.m
//  ZXwalk
//
//  Created by 张祥 on 15/10/24.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "TransitionView.h"

@implementation TransitionView

/*
 
 1.UI给的图是按480*1136,所有的尺寸都要除以2
 2.label的高度是按字体给的,比如40的字体,则这个label的高度就是20左右
 3.在使用xib的时候自定义view的大小不是随便的,得根据UI图大概计算出需要多宽,多高合适,然后在进行autolayout
 4.所有在autolayout上设置的,距离都是死的,比如说拖了一个label距离上端30,则不管在什么尺寸的屏幕上都是距离上端30,而不是想当然的按比例缩
 
 
 5.label的自适应高度是直接拖出来的,不是计算后更改frame
 6.拖控件的时候有一种,两个控件可以水平对齐的,就例如这个自适应高度的label,下面的图片和下面的label可以水平对齐,这样就不用再多拖一个label了
 */








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
