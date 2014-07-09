//
//  NSString+File.h
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)
// 在文件名后拼接一段字符串（扩展名不变）
- (NSString *)fileNameAppendString:(NSString *)str;

// 根据count是否超过1万来返回字符串
+ (NSString *)withinWanStr:(int)count;
@end
