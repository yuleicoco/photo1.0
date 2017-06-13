//
//  MyfamilymemberModel.h
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseJSONModel.h"

@interface MyfamilymemberModel : BaseJSONModel
@property (nonatomic, copy) NSString *did;
@property (nonatomic, copy) NSString *deviceno;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *accountnumber;
@property (nonatomic, copy) NSString *headportrait;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *type;

@end
