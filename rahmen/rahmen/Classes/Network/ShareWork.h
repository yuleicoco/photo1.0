//
//  ShareWork.h
//  funpaw
//
//  Created by yulei on 17/2/6.
//  Copyright © 2017年 yulei. All rights reserved.
//


#define BASE_URL    @"clientAction.do?method=json&classes=appinterface&"


#import <AFNetworking/AFNetworking.h>
#import "BaseModel.h"



//请求成功回调block
typedef void (^requestSuccessBlock)(BaseModel *model);



//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface ShareWork : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;


//// 获取公网IP地址
//- (void)requestNetWorkWithSuccessBlock:(requestNetBlock)success
//                       WithFailurBlock:(requestFailureBlock)failure;




@end
