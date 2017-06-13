//
//  BaseModel.h
//  funpaw
//
//  Created by yulei on 17/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel

@property (nonatomic, strong) NSDictionary *retVal;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *retDesc;

@property (nonatomic, copy) NSString *retCode;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic ,assign)int totalrecords;

@end
