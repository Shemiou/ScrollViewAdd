//
//  AddScrollView.h
//  0916HomeworkQuanQuan
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYAddScrollView : UIView
//存放图片资源
@property(nonatomic,strong)NSArray *images;

//scrollview
@property(nonatomic,strong)UIScrollView *scrollView;

//pageControl
@property(nonatomic,strong)UIPageControl *pageControl;

//定时器
@property(nonatomic,retain)NSTimer *timer;

//类方法，直接调用;返回这个view；存放有scrollView
+ (id)addScrollViewWithImageArray:(NSArray *)array andFrame:(CGRect)frame;

@end
