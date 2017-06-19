//
//  AFHttpClient+Devices.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient+Devices.h"
#import "MyvideoModel.h"

@implementation AFHttpClient (Devices)
-(void)getNewMsgWithUserid:(NSString *)userid type:(NSString *)type page:(NSString *)page complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"getNewMsg";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"type"] = type;
    dataparms[@"page"]=page;
    parms[@"data"] =dataparms;

    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [NewmessageModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    
    
}
-(void)queryUserDeviceInfoWithUserid:(NSString *)userid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryUserDeviceInfo";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [MyDevicesModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];






}







-(void)queryByIddeviceInfoWithUserid:(NSString *)userid did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryByIdDeviceInfo";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
      //  model.list = [MyDevicesModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    


}

-(void)queryFamilyMemberWithUserid:(NSString *)userid did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryFamilyMember";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
  //  dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
          model.list = [MyfamilymemberModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    
}



-(void)removesomebodyWithUserid:(NSString *)userid admin:(NSString *)admin did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = admin;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"remove";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    dataparms[@"admin"] = admin;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
      //  model.list = [MyfamilymemberModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];





}


-(void)transfersomebodyWithUserid:(NSString *)userid admin:(NSString *)admin did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{

    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = admin;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"transfer";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    dataparms[@"admin"] = admin;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        //  model.list = [MyfamilymemberModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}

-(void)queryVideosByDidWithUserid:(NSString *)userid did:(NSString *)did page:(NSString *)page complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryVideosByDid";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    dataparms[@"page"] = page;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
          model.list = [MyvideoModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];





}


-(void)sendVideoWithUserid:(NSString *)userid did:(NSString *)did content:(NSString *)content video:(NSString *)video complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"sendVideo";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    dataparms[@"content"] = content;
    dataparms[@"video"] = video;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
       
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}
-(void)requestBindingWithUserid:(NSString *)userid deviceno:(NSString *)deviceno complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"requestBinding";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"deviceno"] = deviceno;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
    
        if (model) {
            completeBlock(model);
        }
        
    }];
    


}

-(void)sendResponseWithUserid:(NSString *)userid brid:(NSString *)brid operate:(NSString *)operate type:(NSString *)type complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"sendResponse";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"brid"] = brid;
    dataparms[@"operate"] = operate;
    dataparms[@"type"] = type;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];


}

-(void)unbundlingWithUserid:(NSString *)userid did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"unbundling";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];



}

-(void)inviteRequestWithUserid:(NSString *)userid phone:(NSString *)phone deviceno:(NSString *)deviceno complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"inviteRequest";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"phone"] = phone;
    dataparms[@"deviceno"] = deviceno;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}

-(void)getNewMsgNumWithUserid:(NSString *)userid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"getNewMsgNum";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    



}

-(void)setNewMsgIsReadWithUserid:(NSString *)userid type:(NSString *)type complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"setNewMsgIsRead";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"type"] = type;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    

}

-(void)setVideoIsReadWithUserid:(NSString *)userid did:(NSString *)did complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"setVideoIsRead";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];




}

-(void)modifyDeviceRemarkWithUserid:(NSString *)userid did:(NSString *)did remark:(NSString *)remark complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"device";
    parms[@"action"] = @"modifyDeviceRemark";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] = did;
    dataparms[@"remark"] = remark;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];







}





@end
