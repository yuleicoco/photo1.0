//
//  AccountViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"
#import "AboutViewController.h"
#import "NewPhotoalbumViewController.h"
#import "AFHttpClient+Login.h"
#import "ExchangePasswordViewController.h"

static NSString * cellId = @"accounttablvewCellid";
@interface AccountViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//下面的两组数据
@property (nonatomic,strong)NSArray * imageArry;
@property (nonatomic,strong)NSArray * nameArray;
//上面界面
@property (nonatomic,strong)UIImageView * headImage;


@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * centerView;
@property (nonatomic,strong)UITextField * numBerTextField;
@property (nonatomic,assign)BOOL isAdd;

@property (nonatomic,strong)UIView * downWithView;
@property (nonatomic,strong)UIButton * coverButton;
@property (nonatomic,strong)UIView * littleDownView;
@property(nonatomic,strong)UIImagePickerController * imagePicker;
@property (nonatomic,strong)NSString * picstr;

@property(nonatomic,strong)UILabel * nameLabel;
@end

@implementation AccountViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Account"];
    self.view.backgroundColor = BACKGRAY_COLOR;
    _imagePicker =[[UIImagePickerController alloc]init];
    _imagePicker.delegate= self;
}
-(void)setupView{
    [super setupView];
    
}

-(void)setupData{
    [super setupData];
    [self.dataSource removeAllObjects];
    _imageArry = @[@"phone.png",@"name.png",@"Albums.png",@"password.png",@"about.png"];
    _nameArray = @[NSLocalizedString(@"account_user", nil),NSLocalizedString(@"account_name", nil),NSLocalizedString(@"account_album", nil),NSLocalizedString(@"account_password", nil),NSLocalizedString(@"account_about", nil)];
    [[AFHttpClient sharedAFHttpClient]queryUserWithUserid:[AccountManager sharedAccountManager].loginModel.userid complete:^(BaseModel *model) {
        if (model) {
            [self.dataSource addObject:model.retVal];
            [self initTabView];
            [self.tableView reloadData];
        }
        
    }];
    
    
    
}

-(void)initTabView{
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView.superview);
        make.height.mas_equalTo(206 * W_Hight_Zoom);
        
    }];
    
    _headImage = [[UIImageView alloc]init];
    _headImage.backgroundColor = [UIColor clearColor];
    _headImage.layer.cornerRadius = 55;
    [_headImage.layer setMasksToBounds:YES];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[AccountManager sharedAccountManager].loginModel.headportrait] placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    [topView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImage.superview);
        make.top.equalTo(_headImage.superview.mas_top).with.offset(27);
        make.width.height.mas_equalTo(110);
        
    }];
    
    UIButton * headBtn = [[UIButton alloc]init];
    headBtn.backgroundColor = [UIColor clearColor];
    [headBtn addTarget:self action:@selector(headbuttonTouch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headBtn.superview);
        make.top.equalTo(headBtn.superview.mas_top).with.offset(27);
        make.width.height.mas_equalTo(110);
        
    }];
    
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:17.5];
    _nameLabel.text = [AccountManager sharedAccountManager].loginModel.nickname;
    [topView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameLabel.superview);
        make.top.equalTo(_headImage.mas_bottom).offset(18);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(4);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(252.5);
        
    }];
    [self.tableView registerClass:[AccountTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;
    



}

-(void)headbuttonTouch{
    _downWithView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
    _littleDownView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 667 * W_Hight_Zoom)];
    _coverButton.backgroundColor = [UIColor blackColor];
    _coverButton.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_coverButton];
    [_coverButton addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        _downWithView.frame = CGRectMake(0 * W_Wide_Zoom, 543 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        _littleDownView.frame = CGRectMake(0 * W_Wide_Zoom, 627 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
        _littleDownView.backgroundColor = [UIColor whiteColor];
        _downWithView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_littleDownView];
        [[UIApplication sharedApplication].keyWindow addSubview:_downWithView];
    }];
    NSArray * nameArray = @[NSLocalizedString(@"info_taph", nil),NSLocalizedString(@"info_cam", nil)];
    for (int i = 0; i < 2; i++) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = FENLINE_COLOR;
        [_downWithView addSubview:lineLabel];
        
        UIButton * downButtones = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        [downButtones setTitle:nameArray[i] forState:UIControlStateNormal];
        [downButtones setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        downButtones.titleLabel.font = [UIFont systemFontOfSize:14];
        [_downWithView addSubview:downButtones];
        downButtones.tag = i;
        [downButtones addTarget:self action:@selector(imageButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton * quxiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    [quxiaoButton setTitle:NSLocalizedString(@"Cancel_bind", nil) forState:UIControlStateNormal];
    [quxiaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quxiaoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_littleDownView addSubview:quxiaoButton];
    [quxiaoButton addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];


}


-(void)hideButton:(UIButton *)sender{
    _coverButton.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _downWithView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        _littleDownView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
    }];
}

-(void)imageButtonTouch:(UIButton *)sender{
    if (sender.tag == 0) {
        [self takePhoto];
    }else{
        [self loacalPhoto];
    }
    
}

- (void)takePhoto
{
    [self hideButton:nil];
    // 拍照
    NSArray * mediaty = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.mediaTypes = @[mediaty[0]];
        //设置相机模式：1摄像2录像
        _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //使用前置还是后置摄像头
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //闪光模式
        _imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        _imagePicker.allowsEditing = YES;
    }else
    {
        NSLog(@"打开摄像头失败");
    }
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
    
}


- (void)loacalPhoto
{
    [self hideButton:nil];
    // NSArray * mediaTypers = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //数组的方法有缺陷
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //这里要这样写，才能过滤掉视频，之前的方法过滤不了
        _imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];;
        _imagePicker.allowsEditing = YES;
    }
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSDateFormatter * formater =[[NSDateFormatter alloc]init];
    
    UIImage * showImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"wocaocao:%@",showImage);
    
    // [[NSNotificationCenter defaultCenter]postNotificationName:@"handImageText" object:showImage];
    // _headImage.image = showImage;
    //  [_headBtn setImage:showImage forState:UIControlStateNormal];
    _headImage.image = showImage;
    NSData * data = UIImageJPEGRepresentation(showImage,1.0f);
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    [formater stringFromDate:[NSDate date]];
    NSString *picname1 = [NSString stringWithFormat:@"%@.jpg",[formater stringFromDate:[NSDate date]]];
    
    NSString * pictureDataString = [data base64EncodedStringWithOptions:0];
    // NSLog(@"%@",pictureDataString);
    
   _picstr = [NSString stringWithFormat:@"[{\"%@\":\"%@\",\"%@\":\"%@\"}]",@"name",picname1,@"content",pictureDataString];
    [self changgeheadRequest];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)changgeheadRequest{
    [self showHudInView:self.view hint:@"Exchangeing"];
    [[AFHttpClient sharedAFHttpClient]modifyHeadportraitWithUserid:[AccountManager sharedAccountManager].loginModel.userid image:_picstr complete:^(BaseModel *model) {
         [self hideHud];
        if (model) {
            [[AppUtil appTopViewController]showHint:@"SUCCESS"];
            [AccountManager sharedAccountManager].loginModel.headportrait = model.content;
        }
    }];



}






#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.leftImage.image = [UIImage imageNamed:_imageArry[indexPath.row]];
    cell.nameLabel.text = _nameArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }
    if (indexPath.row == 0 ) {
        cell.rightLabel.text = self.dataSource[0][@"accountnumber"];
    }
    if (indexPath.row == 1) {
        cell.rightLabel.text = self.dataSource[0][@"nickname"];
    }
    
    if (indexPath.row>=2) {
        cell.rightImage.hidden = NO;
    }else{
        
        cell.rightImage.hidden = YES;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }
    if (indexPath.row == 1) {
        NSLog(@"改名字");
        [self exchangename];
    }
    if (indexPath.row == 2) {
        NSLog(@"相册");
        NewPhotoalbumViewController * photo = [[NewPhotoalbumViewController alloc]init];
        [self.navigationController pushViewController:photo animated:NO];
    }
    if (indexPath.row == 3) {
        NSLog(@"改密码");
        ExchangePasswordViewController * exchgangeVc = [[ExchangePasswordViewController alloc]init];
        [self.navigationController pushViewController:exchgangeVc animated:NO];
    }
    if (indexPath.row == 4) {
        NSLog(@"关于");
        AboutViewController  * aboutVc =[[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVc animated:NO];
    }


}


-(void)exchangename{
    _isAdd= YES;
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
    
    UILabel * addLabel = [[UILabel alloc]init];
    addLabel.text = @"Rename";
    addLabel.textColor = [UIColor blackColor];
    addLabel.font = [UIFont systemFontOfSize:17.5];
    [_centerView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (addLabel.superview.mas_centerX);
        make.top.equalTo(addLabel.superview.mas_top).offset(17 *W_Hight_Zoom);
    }];
    
    UILabel * enterLabel = [[UILabel alloc]init];
    enterLabel.text = @"Enter Name";
    enterLabel.font = [UIFont systemFontOfSize:17.5];
    enterLabel.textColor = [UIColor blackColor];
    [_centerView addSubview:enterLabel];
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
    [cancelBtn addTarget:self action:@selector(xiaoshidianji) forControlEvents:UIControlEventTouchUpInside];
    [_centerView addSubview:cancelBtn];
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
    _isAdd = NO;
}
-(void)saveBtntouch{
    if ([AppUtil isBlankString:_numBerTextField.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入名字"];
        return;
    }
    
    [[AFHttpClient sharedAFHttpClient]modifyNicknameWithUserid:[AccountManager sharedAccountManager].loginModel.userid nickname:_numBerTextField.text complete:^(BaseModel *model) {
        if (model) {
            [self xiaoshidianji];
            [self setupData];
            [AccountManager sharedAccountManager].loginModel.nickname = _numBerTextField.text;
            
        }
        
    }];



}


@end
