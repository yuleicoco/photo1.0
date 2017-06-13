//
//  AFHttpClient+Devices.h
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Devices)
//查询消息列表
-(void)getNewMsgWithUserid:(NSString *)userid type:(NSString *)type page:(NSString *)page complete:(void(^)(BaseModel *model))completeBlock;

//查询绑定的所有设备
-(void)queryUserDeviceInfoWithUserid:(NSString *)userid complete:(void(^)(BaseModel *model))completeBlock;

//查询单个设备信息
-(void)queryByIddeviceInfoWithUserid:(NSString *)userid did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//获取家庭成员
-(void)queryFamilyMemberWithUserid:(NSString *)userid did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//管理员移除用户
-(void)removesomebodyWithUserid:(NSString *)userid admin:(NSString *)admin did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//管理员转让
-(void)transfersomebodyWithUserid:(NSString *)userid admin:(NSString *)admin did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//查询视频消息
-(void)queryVideosByDidWithUserid:(NSString *)userid did:(NSString *)did page:(NSString *)page complete:(void(^)(BaseModel *model))completeBlock;

//像设备发送视频
-(void)sendVideoWithUserid:(NSString *)userid did:(NSString *)did content:(NSString *)content video:(NSString *)video complete:(void(^)(BaseModel *model))completeBlock;




@end
