//
//  AddScrollView.m
//  0916HomeworkQuanQuan
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PYAddScrollView.h"
#import "PYHeader.h"

@interface PYAddScrollView()<UIScrollViewDelegate>

@end

@implementation PYAddScrollView

//懒加载
- (UIScrollView *)scrollView{
    
    if (!_scrollView ) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        
        self.scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.bounces = NO;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction:)]];
        
        [self createImageViewWithLocalImageAarray];
    }
    return _scrollView;
}


- (void)createImageViewWithLocalImageAarray{
    
    //设置scrollview的属性
    CGFloat scroll_width = _scrollView.frame.size.width;
    CGFloat scroll_height = _scrollView.frame.size.height;
    
    _scrollView.contentSize = CGSizeMake(scroll_width * (_images.count + 2),_scrollView.frame.size.height);
    
    
    for (int i = 0; i < _images.count + 2; i++) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i*scroll_width, 0, scroll_width, scroll_height)];
        
        if (i == 0) {
            imageview.image = [UIImage imageNamed:_images[_images.count-1]];
        }else if (i == _images.count+1){
            imageview.image = [UIImage imageNamed:_images[0]];
        }else{
            imageview.image = [UIImage imageNamed:_images[i-1]];
        }
        
        [_scrollView addSubview:imageview];
    }
    
    [_scrollView setContentOffset:CGPointMake(scroll_width, 0)];
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.center.x - 20, self.frame.size.height - 20, 40, 60)];
        [self addSubview:_pageControl];
        
        _pageControl.numberOfPages = _images.count;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = RGBColor(0, 255, 255);
        _pageControl.pageIndicatorTintColor = RGBColor(128, 128, 128);
        
    }
    return _pageControl;
}

- (NSArray *)imageArray{
    
    if (!_images) {
        _images = [[NSArray alloc] init];
    }
    return _images;
}

+ (id)addScrollView{
    
    return [[self alloc] init];
}

+ (id)addScrollViewWithImageArray:(NSArray *)array andFrame:(CGRect)frame{
    
    PYAddScrollView *add = [PYAddScrollView addScrollView];
    add.frame = frame;
    add.imageArray = array;
    add.scrollView.frame = frame;
    
    [add createTimer];
    
    return add;
}

//set方法得到imageView
- (void)setImageArray:(NSArray *)imageArray{
        _images = imageArray;
}

//实现换页
- (void)pageAction{
 
    CGFloat scroll_width = _scrollView.frame.size.width;
    int pages = _scrollView.contentOffset.x / scroll_width;
    if (pages == 0) {
        //最前面的一页，
        [_scrollView setContentOffset:CGPointMake(scroll_width * _images.count, 0)];
        _pageControl.currentPage = _images.count;
    }else if (pages == _images.count+1){
        //最后一页
        [_scrollView setContentOffset:CGPointMake(scroll_width, 0)];
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = pages - 1;
    }
    
}

#pragma mark ============= 定时器实现
- (void)createTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction{
    
    float width = CGRectGetWidth(self.scrollView.frame);
    int page = self.scrollView.contentOffset.x / width;
    [self.scrollView setContentOffset:CGPointMake(++page * width, 0) animated:YES];
}

//减速换页
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self pageAction];
}

//定时器的时候每一张图片动画结束之后就换页
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self pageAction];
}

//点击图片达到停止动画的效果
- (void)scrollViewTapAction:(UITapGestureRecognizer *)tap{
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }else{
        [self createTimer];
        [self.timer fire];
    }
}


@end
