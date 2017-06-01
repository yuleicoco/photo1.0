//
//  ShareWork+Login.m
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+Login.h"

@implementation ShareWork (Login)
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = @"";
    params[@"token"] = @"";
    params[@"objective"] = @"user";
    params[@"action"] = @"login";
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"accountnumber"] = userName;
    dataParams[@"password"] = password;
    dataParams[@"model"] = @"6s";
    dataParams[@"brand"] = @"6s";
    dataParams[@"version"] = @"9.3";
    dataParams[@"type"] = @"ios";
    dataParams[@"channelid"] = @"";

    params[@"data"] = dataParams;
    [self requestWithMethod:POST WithPath:@"common=getCode" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        if (model) {
            //NSLog(@"哈哈");
            completeBlock(model);
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];



}
@end
