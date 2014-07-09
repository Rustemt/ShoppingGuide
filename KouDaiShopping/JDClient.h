//
//  JDClient.h
//  JOSME_SDK
//
//  Created by 360buy.com on 13-2-16
//  Copyright (c) 2013 360buy. All rights reserved
//

#import <Foundation/Foundation.h>
#import "JDDialog.h"
#include "JDOauthModel.h"
#import "JDRequest.h"
#import "JDUtils.h"
#import "SBJson.h"

@protocol JDAuthDelegate;

@interface JDClient : NSObject<JDRequestDelegate>{
    id<JDAuthDelegate> _authDelegate;        //认证委托
    NSMutableSet* _requests; //存储请求的集合
    JDDialog* _authDialog;   //加载页面
    NSArray* _permissions;                   //API组名数组
}

@property(nonatomic, retain)JDOauthModel  *oauthModel; //公共的数据结构
@property(nonatomic, assign) id<JDAuthDelegate> authDelegate; //获取access_token的委托

//实例化客户端
- (id)initWithAppId:(NSString *)appId
          appSecret:(NSString *)appSecret;

//选择沙箱环境还是真实环境,YES-->沙箱环境，NO-->京东真实环境
- (BOOL)setSandboxMode:(BOOL)isSandboxMode;

//获取oauthCode
- (void)authorize:(NSString *)redirectUrl
      permission:(NSArray*)permission
      andDelegate:(id<JDAuthDelegate>)delegate;

//程序每次登陆的时候，初始化token
- (void)setAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiredDate:(NSString *)expiredDate;

//判断token是否过期
- (BOOL)isSessionValid;

//token过期后,用户自己刷新
- (void)refreshAccessToken:(NSString *)refreshToken andDelegate:(id<JDAuthDelegate>)delegate;

//向服务器端发送异步请求
- (JDRequest *)requestWithMethodName:(NSString *)methodName
                          andParams:(NSMutableDictionary *)params
                      andHttpMethod:(NSString *)httpMethod
                        andDelegate:(id <JDRequestDelegate>)delegate;

//开发者向服务器发送同步请求
- (JDRequest *)synchronousRequestWithMethodName:(NSString *)methodName andParams:(NSMutableDictionary *)params andHttpMethod:(NSString *)httpMethod;


@end

#pragma mark - 获取access_token的委托方法
@protocol JDAuthDelegate <NSObject>

//获取access_token成功
- (void)jdAuthorized:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiredDate:(NSDate *)expiredDate code:(NSString *)code;

//获取access_toekn失败
- (void)jdNotAuthorized:(BOOL)cancelled error:(NSError *)error;

@end
