//
//  AFHttpClient+MyPhoto.h
//  sebot
//
//  Created by yulei on 16/7/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (MyPhoto)


/**
 *  查询我的相册
 */
-(void)QueryMyPhoto:(NSString *)userid token:(NSString *)token complete:(void (^)(BaseModel * model))completeBlock;



/**
 *  查询相册中的照片
 */


-(void)QueryMyPhotos:(NSString *)userid token:(NSString *)token did:(NSString *)did page:(NSString * )page complete:(void (^)(BaseModel * model))completeBlock;


/**
 *  删除照片
 */

-(void)Deletephoto:(NSString *)userid token:(NSString *)token pids:(NSString *)pids complete:(void (^)(BaseModel * model))completeBlock;
@end
