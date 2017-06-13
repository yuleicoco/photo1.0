//
//  DeviceViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "DeviceViewController.h"
#import "DeviceViewTableViewCell.h"
#import "SentViewController.h"
#import "ReceivedViewController.h"
#import "MydevicesViewController.h"

#import "AFHttpClient+Devices.h"
#import "MyDevicesModel.h"
#import "SaomaoViewController.h"

static NSString * cellId = @"DeviceViewTableViewCellId";
@interface DeviceViewController ()
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * centerView;
@property (nonatomic,strong)UITextField * numBerTextField;

@end

@implementation DeviceViewController
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self shuashuju];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Devices"];
    self.view.backgroundColor =BACKGRAY_COLOR;
    _isAdd = NO;
    [self showBarButton:NAV_RIGHT title:@"Add" fontColor:ZIYELLOW_COLOR hide:NO];
}
-(void)doRightButtonTouch{
//    SaomaoViewController * saomoVC =[[SaomaoViewController alloc]initWithNibName:@"SaomaoViewController" bundle:nil];
//    [self.navigationController pushViewController:saomoVC animated:YES];
    if (_isAdd == YES) {
        return;
    }
    _isAdd= YES;
    _bigBtn = [[UIButton alloc]initWithFrame:self.view.frame];
    _bigBtn.backgroundColor = [UIColor blackColor];
    _bigBtn.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigBtn];
    
    _centerView = [[UIView alloc]init];
    _centerView.backgroundColor = [UIColor whiteColor];
    _centerView.layer.cornerRadius = 4;
    [[UIApplication sharedApplication].keyWindow addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView.superview.mas_centerX);
        make.centerY.equalTo(_centerView.superview.mas_centerY);
        make.width.mas_equalTo(275 * W_Wide_Zoom);
        make.height.mas_equalTo(175 * W_Hight_Zoom);
    }];
    
    UILabel * addLabel = [[UILabel alloc]init];
    addLabel.text = @"Add device";
    addLabel.textColor = [UIColor blackColor];
    addLabel.font = [UIFont systemFontOfSize:17.5];
    [_centerView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (addLabel.superview.mas_centerX);
        make.top.equalTo(addLabel.superview.mas_top).offset(17 *W_Hight_Zoom);
    }];
    
    UILabel * enterLabel = [[UILabel alloc]init];
    enterLabel.text = @"Enter device ID";
    enterLabel.font = [UIFont systemFontOfSize:17.5];
    enterLabel.textColor = [UIColor blackColor];
    [_centerView addSubview:enterLabel];
    [enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(enterLabel.superview.mas_centerX);
        make.top.equalTo(addLabel.mas_bottom).offset(13 * W_Hight_Zoom);
    }];
    
    UIButton * saomiaoBtn = [[UIButton alloc]init];
    [saomiaoBtn setImage:[UIImage imageNamed:@"somiao.png"] forState:UIControlStateNormal];
    [_centerView addSubview:saomiaoBtn];
    [saomiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(saomiaoBtn.superview.mas_right).offset(-23 * W_Wide_Zoom);
        make.top.equalTo(saomiaoBtn.superview.mas_top).offset(20 * W_Hight_Zoom);
        make.width.height.mas_equalTo(17 * W_Hight_Zoom);
    }];
    
    _numBerTextField = [[UITextField alloc]init];
    _numBerTextField.backgroundColor = RGB(240, 240, 240);
    _numBerTextField.layer.cornerRadius = 4;
    _numBerTextField.textColor = [UIColor blackColor];
    _numBerTextField.font = [UIFont systemFontOfSize:15];
   // _numBerTextField.placeholder = @"请输入设备号";
    _numBerTextField.tintColor = ZIYELLOW_COLOR;
    [_centerView addSubview:_numBerTextField];
    [_numBerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_numBerTextField.superview.mas_centerX);
        make.top.equalTo(enterLabel.mas_bottom).offset(12 * W_Hight_Zoom);
        make.width.mas_equalTo(220 * W_Wide_Zoom);
        make.height.mas_equalTo(35 * W_Hight_Zoom);
        
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
    [_centerView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.superview.mas_left);
        make.right.equalTo(shuLabel.mas_left);
        make.top.equalTo(lineLabel.mas_bottom);
        make.bottom.equalTo(cancelBtn.superview.mas_bottom);
    }];
    
    
    
    
    
    
    

}





-(void)setupView{
    [super setupView];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView.superview);
        make.height.mas_equalTo(100.5);
    }];
    
    UIButton * receivedBtn = [[UIButton alloc]init];
    receivedBtn.backgroundColor = [UIColor clearColor];
    [receivedBtn addTarget:self action:@selector(receiveBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:receivedBtn];
    [receivedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(receivedBtn.superview);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = FENLINE_COLOR;
    [topView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineLabel.superview.mas_left).offset(16);
        make.right.equalTo(lineLabel.superview.mas_right).offset(-16);
        make.centerY.equalTo(lineLabel.superview.mas_centerY);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton * sentBtn = [[UIButton alloc]init];
    sentBtn.backgroundColor = [UIColor whiteColor];
    [sentBtn addTarget:self action:@selector(sentBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sentBtn];
    [sentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.left.right.equalTo(sentBtn.superview);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView * receiveImage = [[UIImageView alloc]init];
    [receiveImage setImage:[UIImage imageNamed:@"friendmessage.png"]];
    [topView addSubview:receiveImage];
    [receiveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receivedBtn.mas_centerY);
        make.left.equalTo(receiveImage.superview.mas_left).offset(15);
        make.width.height.mas_equalTo(20);
    }];
    
    UILabel * receiveLabel = [[UILabel alloc]init];
    receiveLabel.text = @"Received";
    receiveLabel.textColor = [UIColor blackColor];
    receiveLabel.font = [UIFont systemFontOfSize:17.5];
    [topView addSubview:receiveLabel];
    [receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receivedBtn.mas_centerY);
        make.left.equalTo(receiveImage.mas_right).offset(16);

    }];
    
    UIImageView * rightjian1 = [[UIImageView alloc]init];
    [rightjian1 setImage:[UIImage imageNamed:@"rightjiantou.png"]];
    [topView addSubview:rightjian1];
    [rightjian1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightjian1.superview.mas_right).offset(-16);
        make.centerY.equalTo(receivedBtn.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(11);
    }];
    
    UIImageView * sentImage = [[UIImageView alloc]init];
    [sentImage setImage:[UIImage imageNamed:@"sent.png"]];
    [topView addSubview:sentImage];
    [sentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sentBtn.mas_centerY);
        make.left.equalTo(sentImage.superview.mas_left).offset(15);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(18);
    }];
    
    UILabel * sentLabel = [[UILabel alloc]init];
    sentLabel.text = @"Sent";
    sentLabel.font = [UIFont systemFontOfSize:17.5];
    sentLabel.textColor = [UIColor blackColor];
    [topView addSubview:sentLabel];
    [sentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sentImage.mas_right).offset(16);
        make.centerY.equalTo(sentBtn.mas_centerY);
    }];
    
    UIImageView * sentRightimage = [[UIImageView alloc]init];
    [sentRightimage setImage:[UIImage imageNamed:@"rightjiantou.png"]];
    [topView addSubview:sentRightimage];
    [sentRightimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sentRightimage.superview.mas_right).offset(-16);
        make.centerY.equalTo(sentBtn.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(11);
        
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(4);
        make.left.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(self.tableView.superview.height - topView.height - 4);
    }];
    [self.tableView registerClass:[DeviceViewTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
}

-(void)setupData{
    [super setupData];
   
     [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]queryUserDeviceInfoWithUserid:[AccountManager sharedAccountManager].loginModel.userid complete:^(BaseModel *model) {
        if (model) {
            if (model.list.count <= 0 ) {
                //这里要做没有数据的处理
            }
            [self.dataSource addObjectsFromArray:model.list];
            [self.tableView reloadData];

        }
    }];


    
    
}

//-(void)shuashuju{
//
//     [self.dataSource removeAllObjects];
//    [[AFHttpClient sharedAFHttpClient]queryUserDeviceInfoWithUserid:[AccountManager sharedAccountManager].loginModel.userid complete:^(BaseModel *model) {
//        if (model) {
//            if (model.list.count <= 0 ) {
//                //这里要做没有数据的处理
//            }
//            [self.dataSource addObjectsFromArray:model.list];
//            [self.tableView reloadData];
//            
//        }
//    }];
//    
//}






#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count <=0) {
        return nil;
    
    }
    MyDevicesModel * model = self.dataSource[indexPath.row];
    DeviceViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }else{
        cell.lineLabel.hidden = NO;
    }
    cell.devicenameLabel.text  = model.deviceremark;
    //后面还有小红点
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}







-(void)receiveBtntouch{
    NSLog(@"shang");
    ReceivedViewController * receivedVc = [[ReceivedViewController alloc]init];
    [self.navigationController pushViewController:receivedVc animated:NO];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NewAlbumAdviceModel * model = self.dataSource[indexPath.row];
    //DeviceViewTableViewCell *cell = (DeviceViewTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    MydevicesViewController * mydevices = [[MydevicesViewController alloc]init];
    mydevices.didstr = model.did;
    [self.navigationController pushViewController:mydevices animated:NO];
    


}



-(void)sentBtntouch{
    NSLog(@"dada");
    SentViewController * sentVc =[[SentViewController alloc]init];
    [self.navigationController pushViewController:sentVc animated:NO];
    
    
    
}




-(void)viewDidDisappear:(BOOL)animated{
    _bigBtn.hidden = YES;
    _centerView.hidden = YES;
    _isAdd = NO;

}








@end
