//
//  MyvideoModel.h
//  rahmen
//
//  Created by czx on 2017/6/12.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseJSONModel.h"

@interface MyvideoModel : BaseJSONModel
@property (nonatomic, copy) NSString *vmid;
@property (nonatomic, copy) NSString *headportrait;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *thumbnails;
@property (nonatomic, copy) NSString *opttime;
@property (nonatomic, copy) NSString *sender;
@property (nonatomic, copy) NSString *receiver;



@end
