//
//  MyDevicesModel.h
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseJSONModel.h"

@interface MyDevicesModel : BaseJSONModel
@property (nonatomic, copy) NSString *did;
@property (nonatomic, copy) NSString *deviceno;
@property (nonatomic, copy) NSString *termid;
@property (nonatomic, copy) NSString *sipno;
@property (nonatomic, copy) NSString *sippw;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createuser;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *deviceremark;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *newvideos;




@end
