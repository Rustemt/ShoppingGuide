//
//  JDRequest.h
//  JOSME_SDK
//  Created by 360buy.com on 13-2-16
//  Copyright (c) 2013 360buy. All rights reserved
//

#import "JDRequest.h"
#import "SBJSON.h"
#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <UIKit/UIKit.h>

@protocol JDRequestDelegate;

@interface JDRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDataDelegate> {
    id<JDRequestDelegate> _delegate;          //请求委托
    NSString             *_url;               //服务器url
    NSString*             _httpMethod;   //请求方式
    NSMutableDictionary  *_params;            //存储产生httpBody所需数据
    NSURLConnection      *_connection;        //提供异步加载
    NSMutableData*        _responseText; //返回数据
    BOOL                  _requestDone;  //是否有返回值
    NSError*              _error;        //返回的错误码
    BOOL                  _sessionDidExpire;  //token是否过期
}

@property(nonatomic,assign) id<JDRequestDelegate> delegate;
@property(nonatomic,copy) NSString* url;
@property(nonatomic,copy) NSString* httpMethod;
@property(nonatomic,retain) NSMutableDictionary* params;
@property(nonatomic,retain) NSURLConnection*  connection;
@property(nonatomic,retain) NSMutableData* responseText;
@property(nonatomic,readonly) BOOL requestDone;
@property(nonatomic,readonly) BOOL sessionDidExpire;
@property(nonatomic,retain) NSError* error;

//实例化请求对象
+ (JDRequest*)getRequestWithParams:(NSMutableDictionary *) params
                        httpMethod:(NSString *) httpMethod
                          delegate:(id<JDRequestDelegate>)delegate
                        requestURL:(NSString *) url;

//检测请求是否在处理
- (BOOL) isLoading;

//发起异步连接
- (void)asynchronousConnect;

//发起同步连接
- (NSData *)synchronousConnect;
@end

#pragma mark - JDRequestDelegate 代理方法
@protocol JDRequestDelegate <NSObject>

@optional

//接受服务器返回数据回调函数
- (void)request:(JDRequest *)request didReceiveResponse:(NSURLResponse *)response;

//接收服务器返回数据回调函数
- (void)request:(JDRequest *)request didDidReceiveData:(NSData *)data;

//请求错误回调函数
- (void)request:(JDRequest *)request didFailWithError:(NSError *)error;

//回调函数
- (void)request:(JDRequest *)request didLoad:(id)result;
@end
