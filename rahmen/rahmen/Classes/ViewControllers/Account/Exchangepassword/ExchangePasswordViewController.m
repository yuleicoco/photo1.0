//
//  ExchangePasswordViewController.m
//  rahmen
//
//  Created by czx on 2017/6/16.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ExchangePasswordViewController.h"
#import "RegiestTableViewCell.h"
#import "AFHttpClient+Login.h"

static NSString * cellId = @"RegiestTableViewCellId22222";
@interface ExchangePasswordViewController ()
//图片数组
@property (nonatomic,strong)NSArray * imageArray;

@property (nonatomic,strong)UITextField * emailTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@property (nonatomic,strong)UITextField * repasswordTextfield;
@end

@implementation ExchangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Password"];
    self.view.backgroundColor = BACKGRAY_COLOR;
}

-(void)setupView{
    [super setupView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(151);
        
    }];
    [self.tableView registerClass:[RegiestTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;
    
    _emailTextfield = [[UITextField alloc]init];
    _emailTextfield.textColor = [UIColor blackColor];
    _emailTextfield.font = [UIFont systemFontOfSize:17.5];
    [_emailTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _emailTextfield.tintColor = ZIYELLOW_COLOR;
    _emailTextfield.placeholder = @"Oldpassword";
    [self.view addSubview:_emailTextfield];
    [_emailTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_emailTextfield.superview.mas_left).offset(50);
        make.top.equalTo(_emailTextfield.superview);
        make.height.mas_equalTo(50);
        make.right.equalTo(_emailTextfield.superview.mas_right);
        
    }];
    _passwordTextfield = [[UITextField alloc]init];
    _passwordTextfield.textColor = [UIColor blackColor];
    _passwordTextfield.font = [UIFont systemFontOfSize:17.5];
    [_passwordTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextfield.tintColor = ZIYELLOW_COLOR;
    _passwordTextfield.placeholder = @"Password";
    [self.view addSubview:_passwordTextfield];
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordTextfield.superview.mas_left).offset(50);
        make.top.equalTo(_emailTextfield.mas_bottom);
        make.height.mas_equalTo(50);
        make.right.equalTo(_passwordTextfield.superview.mas_right);
        
    }];
    
    _repasswordTextfield = [[UITextField alloc]init];
    _repasswordTextfield.textColor = [UIColor blackColor];
    _repasswordTextfield.font = [UIFont systemFontOfSize:17.5];
    _repasswordTextfield.tintColor = ZIYELLOW_COLOR;
    [_repasswordTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _repasswordTextfield.placeholder = @"Re-enter Password";
    [self.view addSubview:_repasswordTextfield];
    [_repasswordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_repasswordTextfield.superview.mas_left).offset(50);
        make.top.equalTo(_passwordTextfield.mas_bottom);
        make.height.mas_equalTo(50);
        make.right.equalTo(_repasswordTextfield.superview.mas_right);
        
    }];
    
    UIButton * registerBtn = [[UIButton alloc]init];
    registerBtn.backgroundColor = ZIYELLOW_COLOR;
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    registerBtn.layer.cornerRadius = 4;
    [registerBtn addTarget:self action:@selector(regiestButtontouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(registerBtn.superview.mas_bottom).offset(-305);
        make.centerX.equalTo(registerBtn.superview.mas_centerX);
    }];
    

    
}

-(void)regiestButtontouch{
    if ([AppUtil isBlankString:_emailTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入旧密码"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入新密码"];
        return;
    }
    if ([AppUtil isBlankString:_repasswordTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请再次输入新密码"];
        return;
    }
    if (![_emailTextfield.text isEqualToString:[AccountManager sharedAccountManager].loginModel.password]) {
        [[AppUtil appTopViewController]showHint:@"旧密码输入错误"];
        return;
    }
    if (![_passwordTextfield.text isEqualToString:_repasswordTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"两次输入的密码不一致"];
        return;
    }
    
    [[AFHttpClient sharedAFHttpClient]modifyPasswordWithUserid:[AccountManager sharedAccountManager].loginModel.userid oldpassword:_emailTextfield.text newpassword:_passwordTextfield.text complete:^(BaseModel *model) {
        if (model) {
            [[AppUtil appTopViewController]showHint:model.retDesc];
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
    
        

        }
        
    }];



}



-(void)setupData{
    [super setupData];
    _imageArray = @[@"password.png",@"password.png",@"password.png"];
    
}
#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegiestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    cell.leftImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
