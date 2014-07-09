//
//  JDDialog.h
//  JOSME_SDK
//  Created by 360buy.com on 13-2-16
//  Copyright (c) 2013 360buy. All rights reserved
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSON.h"

@protocol JDDialogDelegate;


/**
 * 不要直接使用本接口，在JDClient.h中使用
 *
 * JingDong dialog interface for start the JingDong webView UIServer Dialog.
 */

@interface JDDialog : UIView <UIWebViewDelegate> {
    id<JDDialogDelegate> _delegate;
    NSMutableDictionary *_params;
    NSString * _serverURL;
    NSURL* _loadingURL;
    NSString* _redirectURL;
    UIWebView* _webView;
    UIActivityIndicatorView* _spinner;
    UIButton* _closeButton;
    UIInterfaceOrientation _orientation;
    BOOL _showingKeyboard;
    BOOL _isViewInvisible;
    
    // Ensures that UI elements behind the dialog are disabled.
    UIView* _modalBackgroundView;
}

/**
 * delegate.
 */
@property(nonatomic,assign) id<JDDialogDelegate> delegate;

/**
 * 参数
 */
@property(nonatomic, retain) NSMutableDictionary* params;

//根据url中的节点获取对应的值
- (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle;

- (id)initWithURL: (NSString *) serverURL
      redirectURL: (NSString *) redirectURL
           params: (NSMutableDictionary *) params
  isViewInvisible: (BOOL) isViewInvisible
         delegate: (id <JDDialogDelegate>) delegate;

/**
 * 动画显示视图
 *
 * 视图将被添加到当前窗口顶部
 */
- (void)show;

/**
 * 显示对话框第一页
 *
 * 不要直接调用本方法，在子类中覆盖
 */
- (void)load;

/**
 * 在对话框中载入一个URL
 */
- (void)loadURL:(NSString*)url
            get:(NSDictionary*)getParams;

/**
 * 隐藏视图并通知delegate成功或取消
 */
- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated;

/**
 * 隐藏视图并通知delegate错误发生
 */
- (void)dismissWithError:(NSError*)error animated:(BOOL)animated;

/**
 * 子类应该覆盖此方法以在对话框显示前执行某些操作
 */
- (void)dialogWillAppear;

/**
 * 子类应该覆盖此方法以执行对话框隐藏后续操作
 */
- (void)dialogWillDisappear;

/**
 * 子类应该覆盖此方法以处理从服务器重定向URL传入的数据
 *
 * 必须在合适地方调用dismissWithSuccess:YES以隐藏对话框.
 */
- (void)dialogDidSucceed:(NSURL *)url;

/**
 * 子类应该覆盖此方法以处理从服务器重定向URL传入的数据
 *
 * 必须在合适地方调用dismissWithSuccess:YES以隐藏对话框.
 */
- (void)dialogDidCancel:(NSURL *)url;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////

/*
 *应用实现此delegate
 */
@protocol JDDialogDelegate <NSObject>

@optional

/**
 * 当对话框成功完成将消失时调用本方法
 */
- (void)dialogDidComplete:(JDDialog *)dialog;

/**
 * 当对话框成功完成调用本方法，同时返回一个URL
 */
- (void)dialogCompleteWithUrl:(NSURL *)url;

/**
 * 当对话框被用户取消调用本方法
 */
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url;

/**
 * 当对话框被用户取消并将消失调用本方法
 */
- (void)dialogDidNotComplete:(JDDialog *)dialog;

/**
 * 当对话框因为错误载入失败调用本方法
 */
- (void)dialog:(JDDialog*)dialog didFailWithError:(NSError *)error;

/**
 * 询问是否在外部浏览器打开一个用户点击的链接
 */
- (BOOL)dialog:(JDDialog*)dialog shouldOpenURLInExternalBrowser:(NSURL *)url;

@end