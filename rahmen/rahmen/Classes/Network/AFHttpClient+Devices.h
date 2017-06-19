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

//用户请求绑定
-(void)requestBindingWithUserid:(NSString *)userid deviceno:(NSString *)deviceno complete:(void(^)(BaseModel *model))completeBlock;

//用户响应绑定
-(void)sendResponseWithUserid:(NSString *)userid brid:(NSString *)brid operate:(NSString *)operate type:(NSString *)type complete:(void(^)(BaseModel *model))completeBlock;

//解除绑定
-(void)unbundlingWithUserid:(NSString *)userid did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//管理员邀请绑定
-(void)inviteRequestWithUserid:(NSString *)userid phone:(NSString *)phone deviceno:(NSString *)deviceno complete:(void(^)(BaseModel *model))completeBlock;

//小红点消息数量
-(void)getNewMsgNumWithUserid:(NSString *)userid complete:(void(^)(BaseModel *model))completeBlock;

//更新消息阅读状态
-(void)setNewMsgIsReadWithUserid:(NSString *)userid type:(NSString *)type complete:(void(^)(BaseModel *model))completeBlock;

//更新视频消息阅读状态
-(void)setVideoIsReadWithUserid:(NSString *)userid did:(NSString *)did complete:(void(^)(BaseModel *model))completeBlock;

//修改设备备注名
-(void)modifyDeviceRemarkWithUserid:(NSString *)userid did:(NSString *)did remark:(NSString *)remark complete:(void(^)(BaseModel *model))completeBlock;



@end
