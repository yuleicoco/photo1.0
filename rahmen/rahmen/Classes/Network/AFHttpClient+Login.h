//
//  AFHttpClient+Login.h
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Login)
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void(^)(BaseModel *model))completeBlock;
@end
