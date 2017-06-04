//
//  LoginViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHttpClient+Login.h"
#import "LoginModel.h"
#import "RegistViewController.h"
#import "ForgetpasswordViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong)UITextField * usernameTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;

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
    
    
    
    _usernameTextfield = [[UITextField alloc]init];
    _usernameTextfield.textColor = [UIColor blackColor];
    _usernameTextfield.font = [UIFont systemFontOfSize:17.5];
    _usernameTextfield.tintColor = ZIYELLOW_COLOR;
    _usernameTextfield.placeholder = NSLocalizedString(@"login_placeholderUsername", nil);
    [_usernameTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [whiteView addSubview:_usernameTextfield];
    [_usernameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usernameImage.mas_right).with.offset(17);
        make.right.equalTo(_usernameTextfield.superview);
        make.top.equalTo(_usernameTextfield.superview);
        make.height.mas_equalTo(50);
       
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
    
    _passwordTextfield = [[UITextField alloc]init];
    _passwordTextfield.textColor = [UIColor blackColor];
    _passwordTextfield.font = [UIFont systemFontOfSize:17.5];
    _passwordTextfield.tintColor = ZIYELLOW_COLOR;
    _passwordTextfield.placeholder = NSLocalizedString(@"login_placeholderPassword", nil);
    [_passwordTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [whiteView addSubview:_passwordTextfield];
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_passwordTextfield.superview);
        make.right.equalTo(_passwordTextfield.superview);
        make.left.equalTo(_usernameTextfield);
        make.height.mas_equalTo(50);
    
    }];
    
    UILabel * ReLabel = [[UILabel alloc]init];
    ReLabel.text = NSLocalizedString(@"login_Register", nil);
    ReLabel.textColor = ZIYELLOW_COLOR;
    ReLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:ReLabel];
    [ReLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ReLabel.superview.mas_left).offset(50);
        make.top.equalTo(whiteView.mas_bottom).with.offset(12);
    
    }];
    
    UIButton * registerBtn = [[UIButton alloc]init];
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn addTarget:self action:@selector(registerBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(ReLabel);
        make.left.equalTo(ReLabel);
        make.top.equalTo(ReLabel);
    }];
    
    UILabel * forgetLabel = [[UILabel alloc]init];
    forgetLabel.text = NSLocalizedString(@"login_Forget", nil);
    forgetLabel.textColor = ZIYELLOW_COLOR;
    forgetLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forgetLabel.superview.mas_right).with.offset(-50);
        make.top.equalTo(whiteView.mas_bottom).with.offset(12);
        
    }];

    UIButton * forgetBtn = [[UIButton alloc]init];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn addTarget:self action:@selector(forgetBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(forgetLabel);
        make.left.equalTo(forgetLabel);
        make.top.equalTo(forgetLabel);
        
    }];
    
    UIButton * loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = ZIYELLOW_COLOR;
    [loginBtn setTitle:NSLocalizedString(@"login_sign", nil) forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    loginBtn.layer.cornerRadius = 4;
    [loginBtn addTarget:self action:@selector(loginBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginBtn.superview).with.offset(32);
        make.right.equalTo(loginBtn.superview).with.offset(-32);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(loginBtn.superview).with.offset(-159);
        
    }];
    
    
    
    
    

}

#pragma mark -- 注册
-(void)registerBtnTouch{
    //注册按钮点击
    RegistViewController * reVc = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:reVc animated:NO];

}
#pragma mark -- 忘记密码
-(void)forgetBtnTouch{
    // 忘记密码按钮点击
    ForgetpasswordViewController * forgetVc = [[ForgetpasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetVc animated:NO];
    

}
#pragma mark -- 登录
-(void)loginBtnTouch{
    if ([AppUtil isBlankString:_usernameTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入账号"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入密码"];
        return;
    }
    [self showHudInView:self.view hint:@"正在登录..."];
    
   [[AFHttpClient sharedAFHttpClient]loginWithUserName:_usernameTextfield.text password:_passwordTextfield.text complete:^(BaseModel *model) {
       
       if (model) {
           LoginModel * loginModel = [[LoginModel alloc]initWithDictionary:model.retVal error:nil];

           
           [[AccountManager sharedAccountManager] login:loginModel];
           [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
           
       }
       
   }];
    [self hideHud];

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
