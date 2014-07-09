//
//  UIImage+Fit.h
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Fit)
// 返回一张适应iPhone5\iPhone4的全屏图片
+ (UIImage *)fullscreenImageNamed:(NSString *)name;

#pragma mark 返回拉伸好的图片
+ (UIImage *)resizeImage:(NSString *)imgName;

- (UIImage *)resizeImage;
@end
