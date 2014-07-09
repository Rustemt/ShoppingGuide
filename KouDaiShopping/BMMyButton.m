//
//  BMMyButton.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMMyButton.h"

@implementation BMMyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 1.设置UIImageView
        // 不需要在用户长按的时候调整图片为灰色
        self.adjustsImageWhenHighlighted = NO;
        // 设置UIImageView的图片居中
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

        // 2.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return self;
}
/**
 *  目的是去掉父类在高亮时所做的操作
 */
- (void)setHighlighted:(BOOL)highlighted {}
- (void)setTitle:(NSString *)title Image:(NSString *)imageStr
{
    [self setTitle:title forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:imageStr];
    [self setImage:image forState:UIControlStateNormal];
}


@end
#pragma mark - 覆盖父类的2个方法
#pragma mark 设置按钮标题的frame
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    UIImage *image =  [self imageForState:UIControlStateNormal];
//    CGFloat titleX = image.size.width*0.5;
//    CGFloat titleWidth = self.bounds.size.width - titleX;
//    return CGRectMake(titleX,0, titleWidth,  contentRect.size.height);
//}
//
//#pragma mark 设置按钮图片的frame
//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    UIImage *image = [self imageForState:UIControlStateNormal];
//    return CGRectMake(0, 0, contentRect.size.width * 0.5, contentRect.size.height);
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */