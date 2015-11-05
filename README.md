# ScrollViewAdd
一句话实现图片无限轮播封装类，另加定时器进行播放。
//类方法，直接调用;返回这个view；存放有scrollView
+ (id)addScrollViewWithImageArray:(NSArray *)array andFrame:(CGRect)frame;
直接调用这个类方法创建ScrollView的大小，并且传入本地图片（以数组的形式）。
