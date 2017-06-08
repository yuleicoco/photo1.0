//
//  PhotoGrapgModel.h
//  sego2.0
//
//  Created by czx on 16/12/5.
//  Copyright © 2016年 yulei. All rights reserved.
//

#import <MojoDatabase/MojoDatabase.h>

@interface PhotoGrapgModel : JSONModel
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *photoname;
@property (nonatomic, copy) NSString *networkaddress;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *albumname;


@property (nonatomic, copy) NSArray *networkaddressArray;
@property (nonatomic, copy) NSArray *imagenameArray;
@property (nonatomic, copy) NSArray * pidArray;

@end
