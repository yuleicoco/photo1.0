//
//  AFHttpClient+Login.h
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Login)
//登录
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void(^)(BaseModel *model))completeBlock;
//验证码
- (void)provedWithUserid:(NSString*)userid token:(NSString*)token phone:(NSString *)phone type:(NSString *)type complete:(void(^)(BaseModel *model))completeBlock;
//注册
-(void)registWithphone:(NSString *)phone password:(NSString *)password complete:(void(^)(BaseModel *model))completeBlock;

//忘记密码
-(void)forgetPasswordWithPhone:(NSString *)phone password:(NSString *)password complete:(void(^)(BaseModel *model))completeBlock;



@end
