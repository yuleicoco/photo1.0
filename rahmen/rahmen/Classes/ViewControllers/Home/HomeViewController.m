//
//  HomeViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeviewTableViewCell.h"
#import "SGImagePickerController.h"
#import "AFHttpClient+Alumb.h"
#import "UIImage-Extensions.h"
#import "DetailViewController.h"
#import "LargeViewController.h"
#import "SGPhotoBrowser.h"

#import "SelectAlbumViewController.h"

static NSString * cellId = @"homeviewcellId";
@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//发布按钮的东西
@property (nonatomic,strong)UIButton * pushjiaBtn;
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIButton * albumBtn;
@property (nonatomic,strong)UIButton * snapBtn;
@property (nonatomic,strong)UIButton * closeBtn;
@property (nonatomic,strong)UILabel * albumLabel;
@property (nonatomic,strong)UILabel * snapLabel;

@property(nonatomic,strong)UIImagePickerController * imagePicker;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitieViewImage];
    self.view.backgroundColor = BACKGRAY_COLOR;
    _imagePicker =[[UIImagePickerController alloc]init];
    _imagePicker.delegate= self;
}
-(void)setupView{
    [super setupView];
    // self.tableView.hidden = NO;
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height-100);
    [self.tableView registerClass:[HomeviewTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[self initRefreshView];
    
    _pushjiaBtn = [[UIButton alloc]init];
    _pushjiaBtn.backgroundColor = [UIColor clearColor];
    [_pushjiaBtn setImage:[UIImage imageNamed:@"fabuphoto.png"] forState:UIControlStateNormal];
    [_pushjiaBtn addTarget:self action:@selector(pushjianbtnTouch) forControlEvents:UIControlEventTouchUpInside];
    _pushjiaBtn.hidden = NO;
    [self.view addSubview:_pushjiaBtn];
    [_pushjiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.bottom.equalTo(_pushjiaBtn.superview.mas_bottom).offset(-20);
        make.centerX.equalTo(_pushjiaBtn.superview.mas_centerX);
        
    }];
    [self initRefreshView];
    
    
}

#pragma mark -- 发布按钮点击
-(void)pushjianbtnTouch{
//    SelectAlbumViewController * selectVc = [[SelectAlbumViewController alloc]init];
//    [self.navigationController pushViewController:selectVc animated:NO];
//    return;
    
    _pushjiaBtn.hidden = YES;
    _bigBtn = [[UIButton alloc]initWithFrame:self.view.frame];
    _bigBtn.backgroundColor = [UIColor blackColor];
    _bigBtn.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigBtn];
    
    _albumBtn = [[UIButton alloc]init];
    [_albumBtn setImage:[UIImage imageNamed:@"Album.png"] forState:UIControlStateNormal];
    _albumBtn.backgroundColor = [UIColor clearColor];
    [_albumBtn addTarget:self action:@selector(albumbtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_albumBtn];
    [_albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_albumBtn.superview.mas_left).offset(107.5 * W_Wide_Zoom);
        make.bottom.equalTo(_albumBtn.superview.mas_bottom).offset(-154);
        make.height.width.mas_equalTo(60);
        
    }];
    
    _snapBtn = [[UIButton alloc]init];
    [_snapBtn setImage:[UIImage imageNamed:@"snap.png"] forState:UIControlStateNormal];
    _snapBtn.backgroundColor = [UIColor clearColor];
    [_snapBtn addTarget:self action:@selector(snapbtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_snapBtn];
    [_snapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_snapBtn.superview.mas_right).offset(-107.5 * W_Wide_Zoom);
        make.bottom.equalTo(_snapBtn.superview.mas_bottom).offset(-154);
        make.height.width.mas_equalTo(60);
        
    }];
    
    _albumLabel = [[UILabel alloc]init];
    _albumLabel.text = @"Album";
    _albumLabel.textColor = [UIColor whiteColor];
    _albumLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].keyWindow addSubview:_albumLabel];
    [_albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_albumBtn.mas_centerX);
        make.top.equalTo(_albumBtn.mas_bottom).offset(5);
    }];
    
    _snapLabel = [[UILabel alloc]init];
    _snapLabel.text = @"Snap";
    _snapLabel.textColor = [UIColor whiteColor];
    _snapLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].keyWindow addSubview:_snapLabel];
    [_snapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_snapBtn.mas_centerX);
        make.top.equalTo(_snapBtn.mas_bottom).offset(5);
        
    }];
    
    _closeBtn = [[UIButton alloc]init];
    _closeBtn.backgroundColor = [UIColor clearColor];
    [_closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closebtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_albumLabel.mas_bottom).offset(40);
        make.centerX.equalTo(_closeBtn.superview);
        make.width.height.mas_equalTo(14);
        
        
    }];
    
}

-(void)closebtnTouch{
    _bigBtn.hidden = YES;
    _closeBtn.hidden = YES;
    _albumBtn.hidden = YES;
    _albumLabel.hidden =YES;
    _snapBtn.hidden = YES;
    _snapLabel.hidden = YES;
    _pushjiaBtn.hidden = NO;


}


-(void)albumbtnTouch{
    [self closebtnTouch];
    
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    picker.maxCount = 4;
    //返回选中的原图
    [picker setDidFinishSelectImages:^(NSMutableArray *images) {
        NSLog(@"原图%@",images);
//        IssueViewController * issue = [[IssueViewController alloc]init];
//        issue.aidstr = _aidStr;
//        issue.choseeImage = images;
//        [self.navigationController pushViewController:issue animated:NO];
        SelectAlbumViewController * Vc = [[SelectAlbumViewController alloc]init];
        Vc.choseeImage = images;
        [self.navigationController pushViewController:Vc animated:NO];

    }];
    [self presentViewController:picker animated:YES completion:nil];


}

-(void)snapbtnTouch{
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

//得到图片之后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    UIImage * getImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageArray addObject:getImage];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
//    IssueViewController * issue = [[IssueViewController alloc]init];
//    issue.choseeImage = imageArray;
//    
//    issue.aidstr = _aidStr;
//    
//    [self.navigationController pushViewController:issue animated:NO];
    SelectAlbumViewController * Vc = [[SelectAlbumViewController alloc]init];
    Vc.choseeImage = imageArray;
    [self.navigationController pushViewController:Vc animated:NO];

    
    
}



#pragma mark -- 数据
-(void)loadDataSourceWithPage:(int)page{
//    [_noShujuImage removeFromSuperview];
//    _noShujuImage.hidden = YES;
    [[AFHttpClient sharedAFHttpClient]familyArticlesWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid page:[NSString stringWithFormat:@"%d",page] complete:^(BaseModel *model) {
        if (model) {
            if (page == START_PAGE_INDEX) {
                if (model.list.count == 0) {
                    //  [self noShuju];
                }
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray:model.list];
            } else {
                [self.dataSource addObjectsFromArray:model.list];
            }
            
            if (model.list.count < REQUEST_PAGE_SIZE){
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            [self.tableView reloadData];
        }
       
        [self handleEndRefresh];
        
    }];
    
}







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
    return 396;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyquanModel * model = self.dataSource[indexPath.row];
    HomeviewTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0) {
        cell.topView.hidden = YES;
    }else{
        cell.topView.hidden = NO;
    }
    cell.nameLabel.text = model.nickname;
    [cell.headImage.layer setMasksToBounds:YES];
    NSString * headStr = model.headportrait;
    NSURL * headUrl = [NSURL URLWithString:headStr];
    [cell.headImage sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"默认头像.png"]];
    if (model.cutImage) {
        cell.bigImage.image = model.cutImage;
    }else{
        [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"默认图片.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                cell.bigImage.image = [image imageByScalingProportionallyToSize:CGSizeMake(self.tableView.width, CGFLOAT_MAX)];
                model.cutImage = cell.bigImage.image;
            }
            
        }];
    }
    
    cell.pinglunBtn.tag = indexPath.row+11;
    [cell.pinglunBtn addTarget:self action:@selector(pinglunbuttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.conttentLabel.text = model.content;
    cell.dateLabel.text = model.publishtime;
    if ([model.praised isEqualToString:@"0"]) {
        cell.dianzanBtn.selected = NO;
    }else{
        cell.dianzanBtn.selected = YES;
    }
    cell.dianzanBtn.userInteractionEnabled = YES;
    
    cell.dianzanBtn.tag = indexPath.row+12;
    [cell.dianzanBtn addTarget:self action:@selector(dianzanbttuntouch:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * bigBtn = [[UIButton alloc]initWithFrame:cell.bigImage.frame];
//    bigBtn.backgroundColor = [UIColor redColor];
//    [cell addSubview:bigBtn];
//    bigBtn.tag = indexPath.row + 13;
//    [bigBtn addTarget:self action:@selector(lookPictureButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.bigBtn.tag = indexPath.row+13;
     [cell.bigBtn addTarget:self action:@selector(lookPictureButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//评论
-(void)pinglunbuttonTouch:(UIButton *)sender{
    NSInteger i = sender.tag - 11;
    NSLog(@"%ld",i);
    FamilyquanModel * model = self.dataSource[i];
    //    CommentViewController * commVc = [[CommentViewController alloc]init];
    //    commVc.wid = model.aid;
    //    [self.navigationController pushViewController:commVc animated:NO];
    DetailViewController * Vcc = [[DetailViewController alloc]init];
    Vcc.wid = model.aid;
    Vcc.indexnumber = i;
    [self.navigationController pushViewController:Vcc animated:NO];
    
}

//点赞
-(void)dianzanbttuntouch:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSInteger i = sender.tag - 12;
    FamilyquanModel * model1 = self.dataSource[i];
    if (sender.selected == YES) {
        sender.userInteractionEnabled = YES;
        [[AppUtil appTopViewController] showHint:@"您已经点过赞了，不能重复点赞哦!"];
    }else{
        [[AFHttpClient sharedAFHttpClient]dianzanWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid objid:model1.aid objtype:@"a" complete:^(BaseModel *model) {
            if (model) {
                [[AppUtil appTopViewController] showHint:model.retDesc];
                //给model重新赋值再刷新tabview
                model1.praised = @"1";
                NSInteger k = [model1.praises integerValue];
                NSInteger kk = k + 1;
                model1.praises = [NSString stringWithFormat:@"%ld",kk];
                [self.tableView reloadData];
            }
            
        }];
        
    }
    
}


//点击查看大图
-(void)lookPictureButtonTouch:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSInteger i = sender.tag - 13;
    NSLog(@"%ld",i);
    FamilyquanModel * model = self.dataSource[i];
    [[AFHttpClient sharedAFHttpClient]lookpictureWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid aid:model.aid complete:^(BaseModel *model) {
        if (model) {
            NSArray * array = model.list;
            
            if (array.count == 0 ) {
                [[AppUtil appTopViewController]showHint:@"照片已删除"];
            }else{
                LargeViewController * largeVC =[[LargeViewController alloc]initWithNibName:@"LargeViewController" bundle:nil];
                largeVC.dataArray = array;
                [self.navigationController pushViewController:largeVC animated:NO];
                sender.userInteractionEnabled = YES;
                
                
            }
        }
    }];
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self closebtnTouch];

}




@end
