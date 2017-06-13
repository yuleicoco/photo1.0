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

static NSString * cellId = @"MydevicesTableViewCellIdd";
@interface MydevicesViewController ()<WechatShortVideoDelegate>
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)NSArray * leftnameArray;
@property (nonatomic,strong)UIButton * videoBtn;

@end

@implementation MydevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Device"];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
  
}
-(void)setupData{
    [super setupData];
    _leftnameArray = @[@"Device",@"Rename",@"Family",@"My video"];
   // [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]queryByIddeviceInfoWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didstr complete:^(BaseModel *model) {
        if (model) {
            if (model.totalrecords == 0) {
                //你已经解绑
                [self.navigationController popViewControllerAnimated:NO];
            }else{
            [self.dataSource addObject:model.retVal];
          //  [self.tableView reloadData];
            [self initTabview];
            
            }
        }
   
        
    }];
    
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
    [_videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_videoBtn.superview.mas_centerX);
        make.top.equalTo(sendVideoBtn.mas_bottom).offset(13* W_Hight_Zoom);
        make.width.mas_equalTo(310 * W_Wide_Zoom);
        make.height.mas_equalTo(45 * W_Hight_Zoom);
    
    }];
    
    
    
    
    
    
    
    
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
    
    if (indexPath.row == 0) {
        if ([model.status isEqualToString:@"ds001"]) {
            cell.rightLabel.text = @"Online";
            cell.rightLabel.textColor = ZIYELLOW_COLOR;
        }else if ([model.status isEqualToString:@"ds002"]){
            cell.rightLabel.text = @"Offline";
            cell.rightLabel.textColor = PLACEHOLDER_COLOR;
        }else if ([model.status isEqualToString:@"ds003"]){
            cell.rightLabel.text = @"BB";
            cell.rightLabel.textColor = PLACEHOLDER_COLOR;
        
        }
        
    }
    
    cell.leftlabel.text = _leftnameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    if (indexPath.row == 2) {
        FamilytabViewController * familyVc = [[FamilytabViewController alloc]init];
        familyVc.didStr = _didstr;
        [self.navigationController pushViewController:familyVc animated:NO];
        
    }
    
    if (indexPath.row == 3) {
        MyvideoViewController * videoVc = [[MyvideoViewController alloc]init];
        videoVc.didStr = _didstr;
        [self.navigationController pushViewController:videoVc animated:NO];
    }
    
    
    
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
