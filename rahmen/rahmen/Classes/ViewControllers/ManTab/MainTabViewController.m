//
//  MainTabViewController.m
//  funpaw
//
//  Created by czx on 2017/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MainTabViewController.h"
#import "HomeViewController.h"
#import "DeviceViewController.h"
#import "AccountViewController.h"

@interface MainTabViewController ()
@property (nonatomic,strong)UINavigationController * eggVc;
@property (nonatomic,strong)UINavigationController * moreVc;

@property (nonatomic,strong)UINavigationController * accountVc;

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

-(void)setupSubviews{
    // self.tabBar.backgroundColor=[UIColor redColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreen.width, 49)];
    backView.backgroundColor = BACKBLACK_COLOR;
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
        self.viewControllers = @[self.eggVc,
                                 self.moreVc,self.accountVc];
//    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
//    self.tabBar.layer.shadowOpacity = 0.4;
//    self.tabBar.layer.shadowRadius = 2;
   // self.tabBarController.tabBar.translucent = NO;
    
}
//device
-(UINavigationController *)eggVc{
    if (!_eggVc) {
        HomeViewController * vc = [[HomeViewController alloc]init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabHome", nil)
                                      image:[[UIImage imageNamed:@"home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"homedian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _eggVc = [[UINavigationController alloc]initWithRootViewController:vc];
    }

    return _eggVc;
}

-(UINavigationController *)moreVc{
    if ((!_moreVc)) {
        DeviceViewController * vc = [[DeviceViewController alloc]init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabDevice", nil)
                                      image:[[UIImage imageNamed:@"devices"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"devicesdian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

        
        _moreVc =[[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _moreVc;
}



-(UINavigationController *)accountVc{
    if (!_accountVc) {
        AccountViewController * vc = [[AccountViewController alloc]init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabAccount", nil)
                                      image:[[UIImage imageNamed:@"Account"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"Accountdian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _accountVc = [[UINavigationController alloc]initWithRootViewController:vc];
        
    }
    
    
    
    
    return _accountVc;
}





-(void)pushViewController:(UIViewController *)viewController{
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        [((UINavigationController*)self.selectedViewController) pushViewController:viewController animated:YES];
        
    }
    


}

@end
