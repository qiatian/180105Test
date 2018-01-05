//
//  LLQHandleImageView.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQHandleImageView.h"
@interface LLQHandleImageView()<UIGestureRecognizerDelegate>

/** 在UIView上添加一张 UIImageView */
@property (nonatomic, weak) UIImageView *imageV;

@end
@implementation LLQHandleImageView
/**
 *1: 懒加载UIImageView，属性修饰也可以用weak修饰，能用weak的时候尽量用weak，其中_imageV = imageV赋值的时候既可以写在添加[self addSubview:imageV];之前也可以写在其之后
 *
 *    @return UIImageView
 */
-(UIImageView *)imageV {
    
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.bounds;
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
        _imageV = imageV;
        //添加手势
        [self addGes];
    }
    return _imageV;
}

-(void)setImage:(UIImage *)image {
    _image = image;
    
    NSLog(@"%@",self.imageV);
    self.imageV.image = image;
    
}
/**
 * 2:添加手势：1：添加了拖拽pan，长按longpress，捏合手势pinch，旋转手势:rotation.1：这些手势都分三种状态，开始，改变，结束，其中在使用这些手势一直绘制的时候，开始只调用一次 2：在这些手势中都可以获得触摸点，locationInView，还可以拖拽距离translationInView，点击的view，旋转角度，捏合比例，而且若是想相对上次改变，则一定要进行复位操作  3：若是想同时支持多个手势，需要将添加的手势设置手势代理，实现otherGestureRecognizer代理方法返回YES，则这样就可以同时支持多个手势。一般涉及旋转平移缩放都与transform一起用，累加形变和非累加形变。 4：复位操作：复位,只要想相对于上一次旋转就复位 [pan setTranslation:CGPointZero inView:pan.view]; pinch.scale = 1;rotation.rotation = 0;
 *
 */
//添加手势
-(void)addGes{
    
    // pan
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(pan:)];
    
    [self.imageV addGestureRecognizer:pan];
    
    // pinch
    // 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinch.delegate = self;
    [self.imageV addGestureRecognizer:pinch];
    
    
    //添加旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    
    [self.imageV addGestureRecognizer:rotation];
    
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageV addGestureRecognizer:longPress];
    
}
//捏合的时候调用.
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    
    pinch.view.transform = CGAffineTransformScale( pinch.view.transform, pinch.scale, pinch.scale);
    // 复位
    pinch.scale = 1;
}


//旋转的时候调用
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    // 旋转图片
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    
    // 复位,只要想相对于上一次旋转就复位
    rotation.rotation = 0;
    
}


//长按的时候调用
// 什么时候调用:长按的时候调用,而且只要手指不离开,拖动的时候会一直调用,手指抬起的时候也会调用
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.25 animations:^{
            //设置为透明
            self.imageV.alpha = 0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.imageV.alpha = 1;
                
                //把当前的View做一个截屏
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                //获取上下文
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                //关闭上下文.
                UIGraphicsEndImageContext();
                
                //调用代理方法
                if([self.delegate respondsToSelector:@selector(handleImageView:newImage:)]) {
                    
                    [self.delegate handleImageView:self newImage:newImage];
                }
                
                //从父控件当中移除
                [self removeFromSuperview];
                
            }];
        }];
        
        
    }
    
}

//拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:pan.view];
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
}


//能够同时支持多个手势
-(BOOL)gestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
