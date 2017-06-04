//
//  ForgetpasswordViewController.m
//  rahmen
//
//  Created by czx on 2017/6/2.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ForgetpasswordViewController.h"
#import "RegiestTableViewCell.h"
#import "AFHttpClient+Login.h"
static NSString * cellId = @"RegiestTableViewCellId1";
@interface ForgetpasswordViewController ()
//图片数组
@property (nonatomic,strong)NSArray * imageArray;
//界面
@property (nonatomic,strong)UIButton * sendBtn;
@property (nonatomic,strong)UITextField * emailTextfield;
@property (nonatomic,strong)UITextField * verficationTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@property (nonatomic,strong)UITextField * repasswordTextfield;
//用来判断的两个string
@property (nonatomic,copy)NSString * achieveString;
@property (nonatomic,copy)NSString * surePhonenumber;
@end

@implementation ForgetpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitieViewImage];
    self.view.backgroundColor = BACKGRAY_COLOR;
}

-(void)setupView{
    [super setupView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(201.5);
        
    }];
    [self.tableView registerClass:[RegiestTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;
    
    _sendBtn = [[UIButton alloc]init];
    _sendBtn.backgroundColor = ZIYELLOW_COLOR;
    _sendBtn.layer.cornerRadius = 14;
    [_sendBtn setTitle:@"Send Code" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_sendBtn addTarget:self action:@selector(sendBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_sendBtn.superview.mas_right).offset(-16);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(27);
        make.top.equalTo(_sendBtn.superview.mas_top).offset(62);
        
        
    }];
    
    _emailTextfield = [[UITextField alloc]init];
    _emailTextfield.textColor = [UIColor blackColor];
    _emailTextfield.font = [UIFont systemFontOfSize:17.5];
    [_emailTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _emailTextfield.tintColor = ZIYELLOW_COLOR;
    _emailTextfield.placeholder = @"E-mail";
    [self.view addSubview:_emailTextfield];
    [_emailTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_emailTextfield.superview.mas_left).offset(50);
        make.top.equalTo(_emailTextfield.superview);
        make.height.mas_equalTo(50);
        make.right.equalTo(_emailTextfield.superview.mas_right);
        
    }];
    
    _verficationTextfield = [[UITextField alloc]init];
    _verficationTextfield.textColor = [UIColor blackColor];
    _verficationTextfield.font = [UIFont systemFontOfSize:17.5];
    [_verficationTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _verficationTextfield.tintColor = ZIYELLOW_COLOR;
    _verficationTextfield.placeholder = @"Verfication code";
    [self.view addSubview:_verficationTextfield];
    [_verficationTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verficationTextfield.superview.mas_left).offset(50);
        make.top.equalTo(_emailTextfield.mas_bottom);
        make.height.mas_equalTo(50);
        make.right.equalTo(_sendBtn.mas_left);
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
        make.top.equalTo(_verficationTextfield.mas_bottom);
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
    [registerBtn setTitle:@"Done" forState:UIControlStateNormal];
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



-(void)sendBtntouch{
    if ([AppUtil isBlankString:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"没输入手机号码"];
        return;
    }
    
    
    
    [self provied];
}


-(void)provied{
    [[AFHttpClient sharedAFHttpClient]provedWithUserid:@"" token:@"" phone:_emailTextfield.text type:@"modifypassword" complete:^(BaseModel *model) {
        if (model) {
            [self timeout];
            _achieveString = model.content;
            _surePhonenumber = model.retDesc;
        }
        
    }];
    
    
}




- (void)timeout
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_sendBtn setTitle:@"Send Code" forState:UIControlStateNormal];
                _sendBtn.userInteractionEnabled = YES;
                _sendBtn.layer.borderWidth = 0;
                _sendBtn.backgroundColor = ZIYELLOW_COLOR;
                [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            });
        }else{
            // int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_sendBtn setTitle:[NSString stringWithFormat:@"%@s",strTime]  forState:UIControlStateNormal];
                [_sendBtn setTitleColor:ZIYELLOW_COLOR forState:UIControlStateNormal];
                [UIView commitAnimations];
                _sendBtn.userInteractionEnabled = NO;
                _sendBtn.layer.borderWidth = 0.5;
                _sendBtn.layer.borderColor = FENLINE_COLOR.CGColor;
                _sendBtn.backgroundColor = [UIColor whiteColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
    
}

-(void)regiestButtontouch{
    if ([AppUtil isBlankString:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入账号"];
        return;
    }
    
    if ([AppUtil isBlankString:_verficationTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入验证码"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入密码"];
        return;
    }
    if (![_passwordTextfield.text isEqualToString:_repasswordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"两次输入密码不一致"];
        return;
    }
    if (![_verficationTextfield.text isEqualToString:_achieveString]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确的验证码"];
        return;
    }
    if (![_emailTextfield.text isEqualToString:_surePhonenumber]) {
        [[AppUtil appTopViewController] showHint:@"手机号码错误"];
        return;
    }
    //    sender.userInteractionEnabled = NO;
    [self showHudInView:self.view hint:@"正在修改..."];
    [[AFHttpClient sharedAFHttpClient]forgetPasswordWithPhone:_emailTextfield.text password:_passwordTextfield.text complete:^(BaseModel *model) {
        if (model) {
            
            //sender.userInteractionEnabled = YES;
            [[AppUtil appTopViewController] showHint:model.retDesc];
            [self.navigationController popViewControllerAnimated:NO];
        }
        [self hideHud];
    }];
    
    
    
    
    
    
    
}





#pragma mark -- 界面东西
-(void)setupData{
    [super setupData];
    _imageArray = @[@"E-mail.png",@"logincode.png",@"password.png",@"password.png"];
}


#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegiestTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.leftImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    if (indexPath.row >= 2) {
        [cell.leftImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.leftImage.superview.mas_left).offset(19);
            make.centerY.equalTo(cell.leftImage.superview);
            //make.width.height.mas_equalTo(16);
            
            
        }];
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




@end
