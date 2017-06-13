//
//  AFHttpClient.h
//  sebot
//
//  Created by ldp on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "BaseModel.h"
#import "FamilyquanModel.h"
#import "CommentModel.h"
#import "NewAlbumModel.h"
#import "NewAlbumAdviceModel.h"
#import "PhotoGrapgModel.h"
#import "NewmessageModel.h"
#import "MyDevicesModel.h"
#import "MyfamilymemberModel.h"

@interface AFHttpClient : AFHTTPSessionManager

singleton_interface(AFHttpClient)


/**
 *  请求的Post方法
 *
 */
- (void)POST:(NSString *)URLString  parameters:(id)parameters result:(void (^)(BaseModel * model))result;

- (void)test;



@end
