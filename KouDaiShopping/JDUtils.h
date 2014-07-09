//
//  JDUtils.h
//  JDPlatformOpening
//  Created by 360buy.com on 13-2-16
//  Copyright (c) 2013 360buy. All rights reserved
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@interface JDUtils : NSObject{
    
}

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod;

+ (NSString *)stringFromDictionary:(NSDictionary *)dict;

+ (NSString *)serializeURL:(NSString *)baseURL param:(NSDictionary *)params httpMethod:(NSString *)httpMethod;

+ (NSString *)stringFromDic:(NSDictionary *)dict;

//读取工程中plist文件
+ (void)dataFromPlist:(NSString *)fileName;
@end

//----->
@interface NSString (JDUtils)
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
- (NSString *)MD5EncodedString;
@end

//----->
@interface NSData(JDUtils)
- (NSString *)MD5EncodedString;

@end

