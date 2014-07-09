//
//  UIButton+Image.m
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIButton+Image.h"
#import "NSString+File.h"
#import "UIImage+Fit.h"

@implementation UIButton (Image)
// 设置一种状态的图片
- (CGSize)setOneStageBackground:(NSString *)name append:(NSString *)append state:(UIControlState)state
{
    // 1.图片名称
    name = [name fileNameAppendString:append];
    // 2.加载图片
    UIImage *image = [UIImage resizeImage:name];
    // 3.设置背景
    [self setBackgroundImage:image forState:state];
    return image.size;
}

// 设置所有状态的图片
- (CGSize)setAllStateBackgound:(NSString *)name
{
    // 1.设置高亮显示的图片
    [self setOneStageBackground:name append:@"_highlighted" state:UIControlStateHighlighted];
    // 2.设置失效图片
    [self setOneStageBackground:name append:@"_disable" state:UIControlStateDisabled];
    // 3.设置普通图片
    return [self setOneStageBackground:name append:nil state:UIControlStateNormal];
}
@end
