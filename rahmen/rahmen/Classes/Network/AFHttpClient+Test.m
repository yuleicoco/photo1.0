//
//  AFHttpClient+Test.m
//  sebot
//
//  Created by czx on 16/7/4.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Test.h"


@implementation AFHttpClient (Test)
-(void)testWithuserid:(NSString *)userid token:(NSString *)token complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"mydevices";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [NewAlbumAdviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];
}






-(void)newphotoWithUserid:(NSString *)userid token:(NSString *)token complete:(void (^)(BaseModel *))completeBlock{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"queryAlbum";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;

    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [NewAlbumModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}


/*
 * 编辑相册
 */
-(void)compliePhoto:(NSString *)userid token:(NSString *)token albumname:(NSString *)albumname dids:(NSString *)dids aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock

{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"modify";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"albumname"] = albumname;
    dataparms[@"dids"]=dids;
    dataparms[@"aid"] = aid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
    
        if (model) {
            completeBlock(model);
        }
        
    }];

    
    
    
}


-(void)delePhoto:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock
{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"delete";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = aid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    
}


-(void)albumdetail:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(BaseModel *model))completeBlock
{

    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"albumdetail";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"aid"] = aid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        model.list = [NewAlbumAdviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
    
}


-(void)addablumWithalbumname:(NSString *)albumname userid:(NSString *)userid dids:(NSString *)dids complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = @"";
    parms[@"objective"] = @"album";
    parms[@"action"] = @"add";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"albumname"] = albumname;
    dataparms[@"dids"] = dids;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];





}






@end
