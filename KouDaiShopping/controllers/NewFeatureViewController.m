//
//  NewFeatureViewController.m
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "BMMenuViewController.h"
#import "UIImage+Fit.h"
#import "UIButton+Image.h"

#define kCount 3

@interface NewFeatureViewController ()
{
    UIButton *_btnShare;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@end

@implementation NewFeatureViewController

#pragma mark 自定义view
- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage fullscreenImageNamed:@"new_feature_background.png"];
    self.view = imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UIPageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.bounds = CGRectMake(0, 0, 100, 0);
    CGSize viewSize = self.view.frame.size;
    _pageControl.center = CGPointMake(viewSize.width * 0.5, viewSize.height - 30);
    [self.view addSubview:_pageControl];
    
    // 2.添加UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    // 3.设置UIScrollView的属性
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kCount * self.view.frame.size.width, 0);
    for (int i = 0; i<kCount; i++) {
        [self addImagViewWithIndex:i];
    }
    
    // 4.设置UIPageControl的属性
    _pageControl.numberOfPages = kCount;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
}

#pragma mark 添加UIImageView
- (void)addImagViewWithIndex:(int)index
{
    CGSize viewSize = self.view.frame.size;
    
    // 1.创建UIImageView
    NSString *name = [NSString stringWithFormat:@"new_feature_%d.png", index+1];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage fullscreenImageNamed:name];
    
    // 2.位置尺寸
    imageView.frame = (CGRect){{viewSize.width * index, 0}, viewSize};
    [_scrollView addSubview:imageView];
    
    // 3.如果是最后一个UIImageView，添加一些按钮
    if (index == kCount - 1) {
        [self initLastImageView:imageView];
    }
}

#pragma mark 初始化最后一个UIImageView
- (void)initLastImageView:(UIImageView *)imageView
{
    CGSize viewSize = self.view.frame.size;
    /*
     1.开始按钮
     */
    // 1.1.创建按钮
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    // 1.2.设置按钮背景和位置尺寸
    CGSize btnStartSize = [btnStart setAllStateBackgound:@"new_feature_finish_button.png"];
    btnStart.bounds = (CGRect){CGPointZero, btnStartSize};
    CGFloat btnStartCenterY = viewSize.height  - btnStartSize.height;
    btnStart.center = CGPointMake(viewSize.width * 0.5, btnStartCenterY +20);
    // 1.3.监听按钮点击
    [btnStart addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     2.分享按钮
     */
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    // 2.1.普通背景
    UIImage *btnShareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
    [btnShare setBackgroundImage:btnShareNormal forState:UIControlStateNormal];
    // 2.2.选中背景
    UIImage *btnShareSelect = [UIImage imageNamed:@"new_feature_share_true.png"];
    [btnShare setBackgroundImage:btnShareSelect forState:UIControlStateSelected];
    // 2.3.默认选中
    btnShare.selected = YES;
    btnShare.adjustsImageWhenHighlighted = NO;
    // 2.4.设置尺寸
    CGSize btnShareSize = btnShareNormal.size;
    btnShare.bounds = (CGRect){CGPointZero, btnShareSize};
    // 2.5.设置中点
    CGPoint btnShareCenter = btnStart.center;
    btnShareCenter.y = btnStart.frame.origin.y - btnShareSize.height*0.5;
    btnShare.center = btnShareCenter;
    // 2.6.添加监听器
    [btnShare addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    _btnShare = btnShare;
    
    // 3.添加按钮，设置跟用户交互
    [imageView addSubview:btnStart];
    [imageView addSubview:btnShare];
    imageView.userInteractionEnabled = YES;
}

#pragma mark 分享
- (void)share:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
}

#pragma mark 开始主界面
- (void)start
{
    if (_startWeibo) {
        _startWeibo(_btnShare.isSelected);
    }
}

#pragma mark UIScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
@end