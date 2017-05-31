//
//  LoginViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGRAY_COLOR;
    [self setupView];
}

-(void)setupView{
    UIImageView * topImage = [[UIImageView alloc]init];
    topImage.image = [UIImage imageNamed:@"huangzi.png"];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.superview.mas_top).offset(117);
        make.width.mas_equalTo(217);
        make.height.mas_equalTo(31);
        make.centerX.equalTo(topImage.superview.mas_centerX);
    }];
    
    UIView * whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteView.superview);
        make.top.equalTo(whiteView.superview.mas_top).offset(260);
        make.height.mas_equalTo(100.5);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = FENLINE_COLOR;
    [whiteView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineLabel.superview);
        make.centerY.mas_equalTo(lineLabel.superview.mas_centerY);
        make.height.mas_equalTo(0.5);
        
        
    }];
    
    
    UIImageView * usernameImage = [[UIImageView alloc]init];
    usernameImage.image = [UIImage imageNamed:@"username.png"];
    [whiteView addSubview:usernameImage];
    [usernameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usernameImage.superview.mas_left).offset(16);
        make.top.equalTo(usernameImage.superview.mas_top).offset(15);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(19);
        
    }];
    
    
    UIImageView * passwordImage = [[UIImageView alloc]init];
    passwordImage.image = [UIImage imageNamed:@"password.png"];
    [whiteView addSubview:passwordImage];
    [passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImage.superview.mas_left).offset(18);
        make.bottom.equalTo(passwordImage.superview.mas_bottom).offset(-14.5);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(21);
        
    }];
    
//    UIButton * registeBtn = [[UIButton alloc]init];
//    [registeBtn setTitle:NSLocalizedString(@"login_Register", nil) forState:UIControlStateNormal];
//    registeBtn.backgroundColor = [UIColor yellowColor];
//    [registeBtn setTitleColor:ZIYELLOW_COLOR forState:UIControlStateNormal];
//    registeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:registeBtn];
//    [registeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(registeBtn.superview.mas_left).offset(50);
//        make.top.mas_equalTo(whiteView.mas_bottom).offset(16);
//        make.width.mas_equalTo(120);
//        
//    }];
//    
    
    
    
    

}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

@end
