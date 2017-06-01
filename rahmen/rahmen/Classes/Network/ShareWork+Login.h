//
//  ShareWork+Login.h
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"

@interface ShareWork (Login)
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void(^)(BaseModel *model))completeBlock;
@end
