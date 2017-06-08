//
//  AFHttpClient+Test.h
//  sebot
//
//  Created by czx on 16/7/4.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Test)
//我的设备（新建相册的时候用来查询设备列表）
-(void)testWithuserid:(NSString *)userid token:(NSString *)token complete:(void(^)(BaseModel *model))completeBlock;

//查询我的相册
-(void)newphotoWithUserid:(NSString *)userid token:(NSString *)token complete:(void(^)(BaseModel *model))completeBlock;

//编辑相册
-(void)compliePhoto:(NSString *)userid token:(NSString *)token albumname:(NSString *)albumname dids:(NSString *)dids aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock;

//删除相册
-(void)delePhoto:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock;


//相册详情
-(void)albumdetail:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock;

//新建相册
-(void)addablumWithalbumname:(NSString *)albumname userid:(NSString *)userid dids:(NSString *)dids complete:(void(^)(BaseModel *model))completeBlock;






@end
