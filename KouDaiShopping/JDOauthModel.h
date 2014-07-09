//
//  JDOauthModel.h
//  Created by 360buy.com on 13-2-16 存储开发者信息
//  Copyright (c) 2013 360buy. All rights reserved
//

#import <Foundation/Foundation.h>

@interface JDOauthModel : NSObject{
    
}

@property(nonatomic, retain)NSString *app_key;
@property(nonatomic, retain)NSString *response_type;
@property(nonatomic, retain)NSString *grant_type;
@property(nonatomic, retain)NSString *redirect_uri;
@property(nonatomic, retain)NSString *client_secret;
@property(nonatomic, retain)NSString *access_code;
@property(nonatomic, retain)NSString *access_token;
@property(nonatomic, retain)NSString *refresh_token;
@property(nonatomic, retain)NSString *expiredDate;
@property(nonatomic, retain)NSString *oauth_Server; //oauth服务器地址
@property(nonatomic, retain)NSString *token_Server;//获取token服务器地址
@property(nonatomic, retain)NSString *api_Server;//调用api服务器地址
@end

