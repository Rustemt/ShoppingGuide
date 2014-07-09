//
//  NSString+File.m
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)
// 在文件名后拼接一段字符串（扩展名不变）
- (NSString *)fileNameAppendString:(NSString *)str
{
    // 如果没有传入任何字符串
    if (str.length == 0) return self;
    
    // 1.文件拓展名
    NSString *extension = [self pathExtension];
    // 2.获得没有拓展名的文件名
    NSString *shortName = [self stringByDeletingPathExtension];
    // 3.拼接str
    NSString *dest = [shortName stringByAppendingString:str];
    // 4.拼接拓展名
    return [dest stringByAppendingPathExtension:extension];
}

+ (NSString *)withinWanStr:(int)count
{
    NSString *str = nil;
    if (count < 10000) {
        str = [NSString stringWithFormat:@"%d", count];
    } else {
        // 整万
        double result = count/10000.0;
        
        if ((int)(result * 10) % 10 == 0) {
            str = [NSString stringWithFormat:@"%.f万", result];
        } else {
            str = [NSString stringWithFormat:@"%.1f万", result];
        }
    }
    return str;
}
@end
