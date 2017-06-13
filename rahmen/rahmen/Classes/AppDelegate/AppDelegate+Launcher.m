//
//  AppDelegate+Launcher.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AppDelegate+Launcher.h"
#import "PopStartView.h"
@interface AppDelegate()<GetScrollVDelegate>

@end

@implementation AppDelegate (Launcher)
- (void)launcherApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       ZIYELLOW_COLOR,NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotificationLoginStateChange object:nil];
//
    
    [self checkLogin];
    //状态栏修改颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)checkLogin{
    if ([AccountManager sharedAccountManager].isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
    }
}

-(void)loginStateChange:(NSNotification *)notification{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {
        [self enterMainTabVC];
    }else{
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        if (![[userdefaults objectForKey:@"STARTFLAG"] isEqualToString:@"1"]) {//第一次启动软件
            [self.window makeKeyAndVisible];
            [userdefaults setObject:@"1" forKey:@"STARTFLAG"];
            [userdefaults synchronize];
            PopStartView *popStartV = [[PopStartView alloc]initWithFrame:self.window.bounds];
            popStartV.delegate = self;
            popStartV.ParentView = self.window;
            [self.window addSubview:popStartV];
            
        }else {//不是第一次启动软件
            [self enterLoginVC];
            
        }
        
        
        
        //   [self enterLoginVC];
        
        
        
    }
    
    
}
- (void)getScrollV:(NSString *)popScroll
{
    
    [self enterLoginVC];
    
    
}

- (void)enterMainTabVC{
    
    if (self.loginVC) {
        self.loginVC = nil;
    }
    
    self.mainTabVC = [[MainTabViewController alloc]init];
    
    self.window.rootViewController = self.mainTabVC;
    
    [self.window makeKeyAndVisible];
   // [self quermember];
    
}
//-(void)quermember{
//    [[AFHttpClient sharedAFHttpClient]queryByIdMemberWithMid:[AccountManager sharedAccountManager].loginModel.mid complete:^(BaseModel *model) {
//        LoginModel * loginModel = [[LoginModel alloc]initWithDictionary:model.retVal error:nil];
//        [[AccountManager sharedAccountManager]login:loginModel];
//        
//    }];
//    
//    
//}
//



/**
 *  进入登陆界面
 */
- (void)enterLoginVC{
    
    if (self.mainTabVC) {
        self.mainTabVC = nil;
    }
    
    self.loginVC = [[LoginViewController alloc]init];
    
    UINavigationController * loginNaVc = [[UINavigationController alloc]initWithRootViewController:self.loginVC];
    self.window.rootViewController = loginNaVc;
    
    [self.window makeKeyAndVisible];
}




@end
