//
//  NewmessageModel.h
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseJSONModel.h"

@interface NewmessageModel : BaseJSONModel
@property (nonatomic, copy) NSString *Brid;
@property (nonatomic, copy) NSString *deviceno;
@property (nonatomic, copy) NSString *headportrat;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *isread;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;

@end
