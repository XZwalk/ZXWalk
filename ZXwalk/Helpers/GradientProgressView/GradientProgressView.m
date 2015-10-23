//
//  GradientProgressView.m
//  GradientProgressView
//
//  Created by Nick Jensen on 11/22/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "GradientProgressView.h"

@implementation GradientProgressView

@synthesize animating, progress;

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        // Use a horizontal gradient
        
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create the gradient colors using hues in 5 degree increments
        
        NSMutableArray *colors = [NSMutableArray array];
        //创建一个包含UIColor的数组，有不同的色调的值
        for (NSInteger deg = 0; deg <= 360; deg += 5) {
            
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * deg / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        [layer setColors:[NSArray arrayWithArray:colors]];
        
        // Create another layer to use as a mask. The width of this layer will
        // be modified to reflect the current progress value.
        
        
        
        
        //为了增加一个标识进度的进行，我们可以使用mask属性来屏蔽一部分
        maskLayer = [CALayer layer];
        
        //创建一个宽度为0的mask覆盖整个View，mask的颜色不重要，当我们progress属性更新的时候我们会增加它的宽度
        [maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:maskLayer];
    }
    return self;
}

+ (Class)layerClass {
    
    // Tells UIView to use CAGradientLayer as our backing layer
    
    return [CAGradientLayer class];
}


//设置progress值的时候我们要确保它在0到1之间
- (void)setProgress:(CGFloat)value {
    
    if (progress != value) {
        
        // progress values go from 0.0 to 1.0
        
        //MIN(a, b), 取两个数之间的最小值
        //fabs(value), 取value的绝对值
        progress = MIN(1.0, fabs(value));
        
        //需要重新布局, 会走layoutSubviews方法
        [self setNeedsLayout];
    }
}


//根据progress属性值更新mask的宽度
- (void)layoutSubviews {
    
    // Resize our mask layer based on the current progress
    
    CGRect maskRect = [maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * progress;
    [maskLayer setFrame:maskRect];
}

- (NSArray *)shiftColors:(NSArray *)colors {
    
    // Moves the last item in the array to the front
    // shifting all the other elements.
    
    //[colors mutableCopy] 创建一个包含所有给定颜色的数组
    NSMutableArray *mutable = [colors mutableCopy];
    //取出最后一种颜色并保存
    id last = [mutable lastObject];
    //移除最后一种颜色
    [mutable removeLastObject];
    //将之前保存的最后一种颜色插入到数组的最前面
    [mutable insertObject:last atIndex:0];
    return [NSArray arrayWithArray:mutable];
}

- (void)performAnimation {
    
    //创建移动的效果，我们可以遍历这个颜色的数组使用layer animation,一个动画结束的时候, 最后一种颜色跑到了最前面
    
    // Update the colors on the model layer
    
    CAGradientLayer *layer = (id)[self layer];
    //得到移动前的颜色数组
    NSArray *fromColors = [layer colors];
    //得到移动后的颜色数组,
    NSArray *toColors = [self shiftColors:fromColors];
    //更新layer的颜色数组
    [layer setColors:toColors];
    
    // Create an animation to slowly move the hue gradient left to right.
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setFromValue:fromColors];
    [animation setToValue:toColors];
    //动画时间间隔
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDelegate:self];
    
    // Add the animation to our layer
    
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    if ([self isAnimating]) {
        
        [self performAnimation];
    }
}

- (void)startAnimating {
    
    if (![self isAnimating]) {
        
        animating = YES;
        
        [self performAnimation];
    }
}

- (void)stopAnimating {
    
    if ([self isAnimating]) {
        
        animating = NO;
    }
}

@end
