//
//  AboutViewController.m
//  rahmen
//
//  Created by czx on 2017/6/2.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    UIButton * exitBtn = [[UIButton alloc]init];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn setTitle:NSLocalizedString(@"about_exit", nil) forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    exitBtn.layer.cornerRadius = 4;
    [exitBtn addTarget:self action:@selector(exitBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(exitBtn.superview.mas_bottom).offset(-140);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(45);
        make.centerX.equalTo(exitBtn.superview.mas_centerX);
    }];
    
    


}

#pragma mark -- 退出
-(void)exitBtntouch{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil) message:NSLocalizedString(@"me_tips", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel_bind", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure_bind", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
        [[AccountManager sharedAccountManager]logout];
        
        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
       // NSString * incodeNumStr = [userDefatluts objectForKey:@"incodeNum"];
        
        for(NSString* key in [dictionary allKeys]){
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }
        [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
       // [userDefatluts setObject:incodeNumStr forKey:@"incodeNum"];
    }]];

    [self presentViewController:alert animated:YES completion:nil];

    
    
    
    
    

}







@end
