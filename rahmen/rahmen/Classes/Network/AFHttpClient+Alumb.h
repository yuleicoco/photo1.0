//
//  AFHttpClient+Alumb.h
//  rahmen
//
//  Created by czx on 2017/6/3.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Alumb)
//上传图片
-(void)issueWithuserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid coneten:(NSString *)content photos:(NSMutableString *)photos userides:(NSString *)userids complete:(void(^)(BaseModel *model))completeBlock;

//家庭圈详情
-(void)familyArticlesWithUserid:(NSString *)userid token:(NSString *)token
                           page:(NSString *)page complete:(void(^)(BaseModel *model))completeBlock;

//点赞
-(void)dianzanWithUserid:(NSString *)userid token:(NSString *)token objid:(NSString *)objid objtype:(NSString *)objtype complete:(void(^)(BaseModel *model))completeBlock;

//查看照片
-(void)lookpictureWithUserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock;


//通过我的设备的接口来判断是否绑定了设备
-(void)querMydeviceWithUserid:(NSString *)userid token:(NSString * )token complete:(void(^)(BaseModel *model))completeBlock;





@end
