//
//  MydevicesViewController.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MydevicesViewController.h"
#import "MydevicesTableViewCell.h"
#import "AFHttpClient+Devices.h"
#import "FamilytabViewController.h"
#import "WechatShortVideoController.h"
#import "MyvideoViewController.h"
#import "MyDevicesModel.h"
#import "InCallViewController.h"

static NSString * cellId = @"MydevicesTableViewCellIdd";
@interface MydevicesViewController ()<WechatShortVideoDelegate>
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)NSArray * leftnameArray;
@property (nonatomic,strong)UIButton * videoBtn;

@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * centerView;


@property (nonatomic,strong)UIButton * bigBtn2;
@property (nonatomic,strong)UIView * centerView2;
@property (nonatomic,strong)UITextField * numBerTextField;
@property (nonatomic,assign)BOOL ischange;
@end

@implementation MydevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Device"];
    _ischange = NO;
    self.view.backgroundColor = BACKGRAY_COLOR;
    [self showBarButton:NAV_RIGHT title:@"Unbing" fontColor:[UIColor whiteColor] hide:NO];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            // 许可对话没有出现，发起授权许可
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    //第一次用户接受
                }else{
                    //用户拒绝
                    return ;
                    
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            
            break;
        default:
            break;
    }
    
    
    
    //麦克风
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        
        if (granted) {
            
            // 用户同意获取麦克风
            NSLog(@"用户同意获取麦克风");
            
        } else {
            
            // 用户不同意获取麦克风
            NSLog(@"用户不同意");
            
        }
        
    }];
    [SephoneManager addProxyConfig:[AccountManager sharedAccountManager].loginModel.sipno password:[AccountManager sharedAccountManager].loginModel.sippw domain:@"www.segosip001.cn"];
    
}
-(void)setupView{
    [super setupView];
  
}
-(void)doRightButtonTouch{
    if (_ischange == YES) {
        return;
    }
    [self jiechuView];



}
-(void)jiechuView{
    if (!_bigBtn) {
        _bigBtn = [[UIButton alloc]init];
    }
    
    _bigBtn.backgroundColor = [UIColor blackColor];
    _bigBtn.alpha = 0.4;
    [self.view addSubview:_bigBtn];
    [_bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_bigBtn.superview);
        
    }];
    
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
    }
    _centerView.backgroundColor = [UIColor whiteColor];
    _centerView.layer.cornerRadius = 4;
    [self.view addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView.superview.mas_centerX);
        make.centerY.equalTo(_centerView.superview.mas_centerY);
        make.width.mas_equalTo(275 * W_Wide_Zoom);
        make.height.mas_equalTo(175 * W_Hight_Zoom);
    }];

    UILabel * wenziLabel = [[UILabel alloc]init];
    wenziLabel.text = @"Are you sure unbind?";
    wenziLabel.textColor = [UIColor blackColor];
    wenziLabel.font = [UIFont systemFontOfSize:18];
    [_centerView addSubview:wenziLabel];
    [wenziLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wenziLabel.superview.mas_centerX);
        make.top.equalTo(wenziLabel.superview.mas_top).offset(34);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = FENLINE_COLOR;
    [_centerView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineLabel.superview);
        make.bottom.equalTo(lineLabel.superview.mas_bottom).offset(-45 * W_Hight_Zoom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    UILabel * shuLabel = [[UILabel alloc]init];
    shuLabel.backgroundColor = FENLINE_COLOR;
    [_centerView addSubview:shuLabel];
    [shuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shuLabel.superview.mas_centerX);
        make.width.mas_equalTo(0.5);
        make.bottom.equalTo(shuLabel.superview);
        make.top.equalTo(lineLabel.mas_bottom);
        
    }];
    
    
    UIButton * cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(xiaoshidianji) forControlEvents:UIControlEventTouchUpInside];
    [_centerView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.superview.mas_left);
        make.right.equalTo(shuLabel.mas_left);
        make.top.equalTo(lineLabel.mas_bottom);
        make.bottom.equalTo(cancelBtn.superview.mas_bottom);
    }];
    
    UIButton * saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"Ok" forState:UIControlStateNormal];
    [saveBtn setTitleColor:ZIYELLOW_COLOR forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    saveBtn.backgroundColor = [UIColor whiteColor];
    [saveBtn addTarget:self action:@selector(saveBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [_centerView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(saveBtn.superview.mas_right);
        make.left.equalTo(shuLabel.mas_right);
        make.top.equalTo(lineLabel.mas_bottom);
        make.bottom.equalTo(saveBtn.superview.mas_bottom);
    }];

    

}

-(void)xiaoshidianji{
    //    _bigBtn.hidden = YES;
    //    _centerView.hidden = YES;
    //   ;
    [_bigBtn removeFromSuperview];
    [_centerView removeFromSuperview];
    //_isAdd = NO;
}

-(void)saveBtntouch{
    [[AFHttpClient sharedAFHttpClient]unbundlingWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didstr complete:^(BaseModel *model) {
        if (model) {
            [self xiaoshidianji];

        }
        
    }];
    
    


}





- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdate:) name:kSephoneCallUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationUpdate:) name:kSephoneRegistrationUpdate object:nil];

    


}
// 通话状态处理
- (void)callUpdate:(NSNotification *)notif {
    SephoneCall *call = [[notif.userInfo objectForKey:@"call"] pointerValue];
    SephoneCallState state = [[notif.userInfo objectForKey:@"state"] intValue];
    
    switch (state) {
        case SephoneCallOutgoingInit:{
            // 成功
            InCallViewController *   _incallVC =[[InCallViewController alloc]init];
            [_incallVC setCall:call];
            [self presentViewController:_incallVC animated:YES completion:nil];

            
            
            break;
        }
            
        case SephoneCallStreamsRunning: {
            break;
        }
        case SephoneCallUpdatedByRemote: {
            break;
        }
            
        default:
            break;
    }
}

// 注册消息处理
- (void)registrationUpdate:(NSNotification *)notif {
    SephoneRegistrationState state = [[notif.userInfo objectForKey:@"state"] intValue];
    switch (state) {
            
        case SephoneRegistrationNone:
            
            NSLog(@"======开始");
            break;
        case SephoneRegistrationProgress:
            NSLog(@"=====注册进行");
            break;
        case SephoneRegistrationOk:
            
            NSLog(@"=======成功");
            break;
        case SephoneRegistrationCleared:
            break;
        case SephoneRegistrationFailed:
            NSLog(@"========OK 以外都是失败");
            break;
            
        default:
            break;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

-(void)initData{
    _leftnameArray = @[@"Device",@"Rename",@"Family",@"My video"];
    [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]queryByIddeviceInfoWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didstr complete:^(BaseModel *model) {
        if (model) {
            if (model.totalrecords == 0) {
                //你已经解绑  发送通知刷新
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                [self.dataSource addObject:model.retVal];
                //  [self.tableView reloadData];
                [self initTabview];
                [self.tableView reloadData];
                
            }
        }
        
    }];

}


-(void)setupData{
    [super setupData];

    
}


-(void)initTabview{
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.font = [UIFont systemFontOfSize:17.5];
    // _numberLabel.text = @"9001";
    [self.view addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_numberLabel.superview.mas_centerX);
        make.top.equalTo(_numberLabel.superview.mas_top).offset(31 * W_Hight_Zoom);
        
    }];
    
    UIImageView * xiangkuangImage = [[UIImageView alloc]init];
    [xiangkuangImage setImage:[UIImage imageNamed:@"Devicexiang.png"]];
    [self.view addSubview:xiangkuangImage];
    [xiangkuangImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(xiangkuangImage.superview.mas_centerX);
        make.top.equalTo(_numberLabel.mas_bottom).offset(15.5 * W_Hight_Zoom);
        make.width.mas_equalTo(180 * W_Wide_Zoom);
        make.height.mas_equalTo(117 * W_Hight_Zoom);
        
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xiangkuangImage.mas_bottom).offset(46 * W_Hight_Zoom);
        make.left.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(201.5 * W_Hight_Zoom);
    }];
    [self.tableView registerClass:[MydevicesTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;

    UIButton * sendVideoBtn = [[UIButton alloc]init];
    sendVideoBtn.backgroundColor = ZIYELLOW_COLOR;
    [sendVideoBtn setTitle:@"Send Video" forState:UIControlStateNormal];
    [sendVideoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendVideoBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    [sendVideoBtn addTarget:self action:@selector(sendvideoButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendVideoBtn];
    [sendVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sendVideoBtn.superview.mas_centerX);
        make.top.equalTo(self.tableView.mas_bottom).offset(30* W_Hight_Zoom);
        make.width.mas_equalTo(310 * W_Wide_Zoom);
        make.height.mas_equalTo(45 * W_Hight_Zoom);
        
    }];
    
    _videoBtn = [[UIButton alloc]init];
    _videoBtn.backgroundColor = [UIColor whiteColor];
    [_videoBtn setTitle:@"Video Call" forState:UIControlStateNormal];
    [_videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _videoBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    [self.view addSubview:_videoBtn];
    [_videoBtn addTarget:self action:@selector(videobuttouTouchhh) forControlEvents:UIControlEventTouchUpInside];
    [_videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_videoBtn.superview.mas_centerX);
        make.top.equalTo(sendVideoBtn.mas_bottom).offset(13* W_Hight_Zoom);
        make.width.mas_equalTo(310 * W_Wide_Zoom);
        make.height.mas_equalTo(45 * W_Hight_Zoom);
    
    }];
    

}

-(void)videobuttouTouchhh{
    MyDevicesModel * model = [[MyDevicesModel alloc]initWithDictionary:self.dataSource[0] error:nil];
     [self sipCall:model.deviceno sipName:nil];





}

- (void)sipCall:(NSString*)dialerNumber sipName:(NSString *)sipName
{
    
    NSString *  displayName  =nil;
//[[SephoneManager instance]call:dialerNumber displayName:displayName transfer:FALSE highDefinition:FALSE];
    [[SephoneManager instance]call:dialerNumber displayName:displayName transfer:FALSE];
    
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
    return 50 * W_Hight_Zoom;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDevicesModel * model = [[MyDevicesModel alloc]initWithDictionary:self.dataSource[0] error:nil];
    MydevicesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    _numberLabel.text = model.deviceno;
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }else{
        cell.lineLabel.hidden = NO;
    }
    if (indexPath.row >1) {
        cell.rightImage.hidden = NO;
        cell.rightLabel.hidden = YES;
    }else{
        cell.rightImage.hidden = YES;
        cell.rightLabel.hidden = NO;
    }
    
    if (indexPath.row == 1) {
        cell.rightLabel.text = model.deviceremark;
    }
    
    if (indexPath.row == 3) {
        if ([model.newvideos isEqualToString:@"0"]) {
             cell.hongdianImage.hidden = YES;
        }else{
             cell.hongdianImage.hidden = NO;
        }
    }else{
        cell.hongdianImage.hidden = YES;
    }
    
    
    if (indexPath.row == 0) {
        if ([model.status isEqualToString:@"ds001"]) {
            cell.rightLabel.text = @"Online";
            cell.rightLabel.textColor = ZIYELLOW_COLOR;
            [_videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _videoBtn.backgroundColor = [UIColor whiteColor];
            _videoBtn.userInteractionEnabled = YES;
            
        }else if ([model.status isEqualToString:@"ds002"]){
            cell.rightLabel.text = @"Offline";
            cell.rightLabel.textColor = PLACEHOLDER_COLOR;
            [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _videoBtn.backgroundColor = RGB(208, 208, 208);
            _videoBtn.userInteractionEnabled = NO;
        }else if ([model.status isEqualToString:@"ds003"]){
            cell.rightLabel.text = @"Busy";
            [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _videoBtn.backgroundColor = RGB(208, 208, 208);
            _videoBtn.userInteractionEnabled = NO;
            cell.rightLabel.textColor = PLACEHOLDER_COLOR;
        
        }
        
    }
    
    cell.leftlabel.text = _leftnameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyDevicesModel * model = [[MyDevicesModel alloc]initWithDictionary:self.dataSource[0] error:nil];
    
    if (indexPath.row == 1) {
        [self exchangeDevicename];
    }
    
    if (indexPath.row == 2) {
        FamilytabViewController * familyVc = [[FamilytabViewController alloc]init];
        familyVc.didStr = _didstr;
        familyVc.devinoStr = model.deviceno;
        [self.navigationController pushViewController:familyVc animated:NO];
        
    }
    
    if (indexPath.row == 3) {
        MyvideoViewController * videoVc = [[MyvideoViewController alloc]init];
        videoVc.didStr = _didstr;
        [self.navigationController pushViewController:videoVc animated:NO];
    }
    
    
    
}

-(void)exchangeDevicename{
    _ischange = YES;
    if (!_bigBtn2) {
        _bigBtn2 = [[UIButton alloc]init];
    }
    
    _bigBtn2.backgroundColor = [UIColor blackColor];
    _bigBtn2.alpha = 0.4;
    [self.view addSubview:_bigBtn2];
    [_bigBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_bigBtn2.superview);
        
    }];
    
    if (!_centerView2) {
        _centerView2 = [[UIView alloc]init];
    }
    _centerView2.backgroundColor = [UIColor whiteColor];
    _centerView2.layer.cornerRadius = 4;
    [self.view addSubview:_centerView2];
    [_centerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView2.superview.mas_centerX);
        make.centerY.equalTo(_centerView2.superview.mas_centerY);
        make.width.mas_equalTo(275 * W_Wide_Zoom);
        make.height.mas_equalTo(175 * W_Hight_Zoom);
    }];
    
    UILabel * addLabel = [[UILabel alloc]init];
    addLabel.text = @"Rename";
    addLabel.textColor = [UIColor blackColor];
    addLabel.font = [UIFont systemFontOfSize:17.5];
    [_centerView2 addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (addLabel.superview.mas_centerX);
        make.top.equalTo(addLabel.superview.mas_top).offset(17 *W_Hight_Zoom);
    }];
    
    UILabel * enterLabel = [[UILabel alloc]init];
    enterLabel.text = @"Enter Name";
    enterLabel.font = [UIFont systemFontOfSize:17.5];
    enterLabel.textColor = [UIColor blackColor];
    [_centerView2 addSubview:enterLabel];
    [enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(enterLabel.superview.mas_centerX);
        make.top.equalTo(addLabel.mas_bottom).offset(13 * W_Hight_Zoom);
    }];
    
    //    UIButton * saomiaoBtn = [[UIButton alloc]init];
    //    [saomiaoBtn setImage:[UIImage imageNamed:@"somiao.png"] forState:UIControlStateNormal];
    //    [_centerView addSubview:saomiaoBtn];
    //    [saomiaoBtn addTarget:self action:@selector(saomiaoButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    //    [saomiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(saomiaoBtn.superview.mas_right).offset(-23 * W_Wide_Zoom);
    //        make.top.equalTo(saomiaoBtn.superview.mas_top).offset(20 * W_Hight_Zoom);
    //        make.width.height.mas_equalTo(17 * W_Hight_Zoom);
    //    }];
    
    _numBerTextField = [[UITextField alloc]init];
    _numBerTextField.backgroundColor = RGB(240, 240, 240);
    _numBerTextField.layer.cornerRadius = 4;
    _numBerTextField.textColor = [UIColor blackColor];
    _numBerTextField.font = [UIFont systemFontOfSize:15];
    // _numBerTextField.placeholder = @"请输入设备号";
    _numBerTextField.tintColor = ZIYELLOW_COLOR;
    [_centerView2 addSubview:_numBerTextField];
    [_numBerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_numBerTextField.superview.mas_centerX);
        make.top.equalTo(enterLabel.mas_bottom).offset(12 * W_Hight_Zoom);
        make.width.mas_equalTo(220 * W_Wide_Zoom);
        make.height.mas_equalTo(35 * W_Hight_Zoom);
        
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = FENLINE_COLOR;
    [_centerView2 addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineLabel.superview);
        make.bottom.equalTo(lineLabel.superview.mas_bottom).offset(-45 * W_Hight_Zoom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    UILabel * shuLabel = [[UILabel alloc]init];
    shuLabel.backgroundColor = FENLINE_COLOR;
    [_centerView2 addSubview:shuLabel];
    [shuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shuLabel.superview.mas_centerX);
        make.width.mas_equalTo(0.5);
        make.bottom.equalTo(shuLabel.superview);
        make.top.equalTo(lineLabel.mas_bottom);
        
    }];
    
    
    UIButton * cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(xiaoshidianji2) forControlEvents:UIControlEventTouchUpInside];
    [_centerView2 addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.superview.mas_left);
        make.right.equalTo(shuLabel.mas_left);
        make.top.equalTo(lineLabel.mas_bottom);
        make.bottom.equalTo(cancelBtn.superview.mas_bottom);
    }];
    
    UIButton * saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:ZIYELLOW_COLOR forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    saveBtn.backgroundColor = [UIColor whiteColor];
    [saveBtn addTarget:self action:@selector(saveBtntouch2) forControlEvents:UIControlEventTouchUpInside];
    [_centerView2 addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(saveBtn.superview.mas_right);
        make.left.equalTo(shuLabel.mas_right);
        make.top.equalTo(lineLabel.mas_bottom);
        make.bottom.equalTo(saveBtn.superview.mas_bottom);
    }];



}

-(void)xiaoshidianji2{
    [_bigBtn2 removeFromSuperview];
    [_centerView2 removeFromSuperview];
    _ischange = NO;
}
-(void)saveBtntouch2{
    [[AFHttpClient sharedAFHttpClient]modifyDeviceRemarkWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didstr remark:_numBerTextField.text complete:^(BaseModel *model) {
        if (model) {
            [self xiaoshidianji2];
            [self initData];
        }
    }];


}




-(void)sendvideoButtonTouch{
    WechatShortVideoController *wechatShortVideoController = [[WechatShortVideoController alloc] init];
    wechatShortVideoController.delegate = self;
    wechatShortVideoController.didStr = _didstr;
    [self.navigationController pushViewController:wechatShortVideoController animated:YES];
        


}



-(void)finishWechatShortVideoCapture:(NSURL *)filePath{
    
    
}




@end
