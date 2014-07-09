//
//  UIImage+Fit.m
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+Fit.h"
#import "BMDefineUtils.h"

@implementation UIImage (Fit)
// 返回一张适应iPhone5\iPhone4的全屏图片
+ (UIImage *)fullscreenImageNamed:(NSString *)name
{
    // 如果是iPhone5
    if (iPhone5) {
        // 给文件名拼接上-568h@2x
      //  name = [name fileNameAppendString:@"-568h@2x"];
    }
    
    // 不需要缓存
    return [UIImage imageNamed:name];
}

#pragma mark 返回拉伸好的图片
+ (UIImage *)resizeImage:(NSString *)imgName {
    return [[UIImage imageNamed:imgName] resizeImage];
}

- (UIImage *)resizeImage
{
    CGFloat leftCap = self.size.width * 0.5f;
    CGFloat topCap = self.size.height * 0.5f;
    // return [self resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, topCap - 1, leftCap - 1) resizingMode:UIImageResizingModeTile];
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}
@end
