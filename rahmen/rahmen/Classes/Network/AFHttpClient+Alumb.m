//
//  AFHttpClient+Alumb.m
//  rahmen
//
//  Created by czx on 2017/6/3.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient+Alumb.h"

@implementation AFHttpClient (Alumb)
-(void)issueWithuserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid coneten:(NSString *)content photos:(NSMutableString *)photos userides:(NSString *)userids complete:(void (^)(BaseModel *))completeBlock{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"upload";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = aid;
    dataparms[@"content"] = content;
    dataparms[@"photos"] = photos;
    dataparms[@"userid"] = userids;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];
}

-(void)familyArticlesWithUserid:(NSString *)userid token:(NSString *)token page:(NSString *)page complete:(void (^)(BaseModel *))completeBlock{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"articles";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"page"] = page;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [FamilyquanModel arrayOfModelsFromDictionaries:model.list];
        if (model) {
            completeBlock(model);
        }
        
    }];
}

-(void)dianzanWithUserid:(NSString *)userid token:(NSString *)token objid:(NSString *)objid objtype:(NSString *)objtype complete:(void (^)(BaseModel *))completeBlock{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"addBehavior";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"objid"] = objid;
    dataparms[@"objtype"] = objtype;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        if (model) {
            completeBlock(model);
        }
    }];
}

-(void)lookpictureWithUserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid complete:(void (^)(BaseModel *))completeBlock{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"articlePics";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = aid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        if (model) {
            completeBlock(model);
        }
    }];
    
    
}


-(void)querMydeviceWithUserid:(NSString *)userid token:(NSString *)token complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = userid;
    params[@"token"] = token;
    params[@"objective"] = @"album";
    params[@"action"] = @"mydevices";
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"userid"] = userid;
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(BaseModel * model) {
        if (model) {
            completeBlock(model);
        }
    }];
    
    
}

@end
