//
//  AFHttpClient+Login.m
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient+Login.h"

@implementation AFHttpClient (Login)
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = @"";
    params[@"token"] = @"";
    params[@"objective"] = @"user";
    params[@"action"] = @"login";
    //data里面传的东西
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"accountnumber"] = userName;
    dataParams[@"password"] = password;
    dataParams[@"model"] = @"6s";
    dataParams[@"brand"] = @"6s";
    dataParams[@"version"] = @"9.3";
    dataParams[@"type"] = @"ios";
    dataParams[@"channelid"] = @"";
    
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(BaseModel *model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];




}
@end
