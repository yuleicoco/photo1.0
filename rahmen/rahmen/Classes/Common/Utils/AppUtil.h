//
//  AppUtil.h
//  petegg
//
//  存放公用方法
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//黑色 tab和导航栏的颜色 #373334
#define BACKBLACK_COLOR RGB(55, 51, 52)

//灰色底色背景 #f5f5f5
#define BACKGRAY_COLOR RGB(245,245,245)

//分割线颜色 #dcdcdc
#define FENLINE_COLOR RGB(220,220,220)

//黄色的字 #f05a28
#define ZIYELLOW_COLOR RGB(240,90,40)

//placehloder的字 #999999
#define PLACEHOLDER_COLOR RGB(153,153,153)


#undef	NAV_BUTTON_MIN_WIDTH
#define	NAV_BUTTON_MIN_WIDTH	(40.0f)

#undef	NAV_BUTTON_MIN_HEIGHT
#define	NAV_BUTTON_MIN_HEIGHT	(40.0f)

#undef	NAV_BAR_HEIGHT
#define	NAV_BAR_HEIGHT	(44.0f)
#define	STATUS_BAR_HEIGHT	(20.0f)
#define	TAB_BAR_HEIGHT	(49.0f)

#define WHITE_FG [UIColor colorWithPatternImage:[UIImage imageNamed:@"white_fg"]]
// 适配代码部分
#define M_Wide 375
#define M_Higth 667

// 缩放比例
#define W_Wide_Zoom [UIScreen mainScreen].bounds.size.width/M_Wide
#define W_Hight_Zoom [UIScreen mainScreen].bounds.size.height/M_Higth
// 海之蓝
#define AllBackColor [UIColor colorWithRed:73/255.0 green:195/255.0 blue:241/255.0 alpha:1]

//分页请求个数
#define REQUEST_PAGE_SIZE           10
#define START_PAGE_INDEX            1

#define BASE_URL @"http://180.97.80.227:15114"


@interface AppUtil : NSObject
// 服务器
+ (NSString *)getServerSego3;
+ (NSString*) getServer;
// 字符判断
+ (BOOL) isBlankString:(NSString *)string;
// 单个颜色grb
+ (CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
// 判断手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;
//判断email
+(BOOL)isValidateEmail:(NSString *)email;
// lable 适应
+ (CGSize)lable:(UILabel *)sender scaleToSize:(CGSize)sizeL;
// 图片处理
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (NSString *)getServerTest;

+ (UIViewController *)appTopViewController;
/**
 *  获取当前时间
 */
+(NSString *)getNowTime;

+(NSString *)getCurrentTime;

/**
 *  机型
 */
+ (NSString *)iphoneType;

@end
