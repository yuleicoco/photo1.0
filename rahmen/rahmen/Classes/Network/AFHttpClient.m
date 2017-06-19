//
//  AFHttpClient.m
//  sebot
//
//  Created by ldp on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@implementation AFHttpClient

singleton_implementation(AFHttpClient)

- (instancetype)init {
    if (self = [super initWithBaseURL:[NSURL URLWithString:BASE_URL]]) {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain", @"application/json", nil];
        
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    
                    break;
                default:
                    break;
            }
        }];
        [self.reachabilityManager startMonitoring];
    }
    return self;
}


- (void)POST:(NSString *)URLString parameters:(id)parameters result:(void (^)(BaseModel * model))result {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (parameters) {
            NSString* paramsStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]  encoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:[paramsStr dataUsingEncoding:NSUTF8StringEncoding] name:@"rp"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        BaseModel* model = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
    
        //根据每一个不同的retcode或者retdesc来写提示
        if ([model.retCode isEqualToString:@"SUCCESS"]) {
             // [[AppUtil appTopViewController] showHint:@"SUCCESS"];
            if (result) {
                result(model);
            }
        }
        
        if ([model.retCode isEqualToString:@"FAIL"]) {
           //  [[AppUtil appTopViewController] showHint:@""];
            
            if (result) {
                result(nil);
            }
        }
        
        
        
        if ([model.retCode isEqualToString:@"D001"]){
            [[AppUtil appTopViewController] showHint:@"设备已经被绑定"];

            if (result) {
                result(nil);
            }
        }
        
        if ([model.retCode isEqualToString:@"D002"]){
            [[AppUtil appTopViewController] showHint:@"设备不存在"];
            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D004"]){
            [[AppUtil appTopViewController] showHint:@"此用户已是家庭成员"];
  
            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D005"]){
            [[AppUtil appTopViewController] showHint:@"此用户不存在"];
    
            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D007"]){
            [[AppUtil appTopViewController] showHint:@"已拒绝"];

            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D008"]){
            [[AppUtil appTopViewController] showHint:@"已同意"];
            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D009"]){
            [[AppUtil appTopViewController] showHint:@"您不是管理员不可移除用户"];

            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D010"]){
            [[AppUtil appTopViewController] showHint:@" 您不是管理员不可转让权限"];

            if (result) {
                result(nil);
            }
        }
        if ([model.retCode isEqualToString:@"D011"]){
            [[AppUtil appTopViewController] showHint:@"管理员不可解绑"];

            if (result) {
                result(nil);
            }
        }
        
        
        
        
    
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [[AppUtil appTopViewController] showHint:@"Network Faild"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        
        if (result) {
            result(nil);
        }
    }];
    
}

- (void)test {
    
//    [self POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"token" : @"1" , @"objective" : @"user" , @"action" : @"queryUser", @"data" : @{@"userid" : @"1"}} result:^(ResponseModel * model) {
//        
//        NSLog(@"%@", model);
//        
//    } ];
    
}

@end
