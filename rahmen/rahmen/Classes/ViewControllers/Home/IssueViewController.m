//
//  IssueViewController.m
//  sebot
//
//  Created by czx on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "IssueViewController.h"
#import "AFHttpClient+Alumb.h"
#import "SGImagePickerController.h"

@interface IssueViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property (nonatomic,strong)UITextView * topTextView;
@property (nonatomic,strong)UIView * downWithView;
@property (nonatomic,strong)UIButton * coverButton;
@property (nonatomic,strong)UIView * littleDownView;
@property (nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)UIImagePickerController * imagePicker;
@property (nonatomic,strong)UIButton * imageButtones;
@property (nonatomic,strong)UILabel * placeholderLabel;

@property(nonatomic,strong)UIView * bigView;

@property (nonatomic,strong)UIButton * leftButton;


@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIButton * albumBtn;
@property (nonatomic,strong)UIButton * snapBtn;
@property (nonatomic,strong)UIButton * closeBtn;
@property (nonatomic,strong)UILabel * albumLabel;
@property (nonatomic,strong)UILabel * snapLabel;

@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,assign)BOOL isFabu;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor grayColor];
    _imagePicker =[[UIImagePickerController alloc]init];
    _imagePicker.delegate= self;
    [self setNavTitle:@"Share a photo"];
    [self showBarButton:NAV_RIGHT title:@"Confirm" fontColor:ZIYELLOW_COLOR hide:NO];
    _isSelect = NO;
    _isFabu = NO;
    
//    CGSize titleSize =self.navigationController.navigationBar.bounds.size;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleSize.width/2,titleSize.height)];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text=@"发布";
//    self.navigationItem.titleView=label;
//
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    // [self showBarButton:NAV_RIGHT title:@"发布" fontColor:[UIColor whiteColor]];
    self.view.backgroundColor = BACKGRAY_COLOR;
//
//    UIButton *releaseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//    //[releaseButton setTitle:@"发布" forState:normal];
//    [releaseButton setImage:[UIImage imageNamed:@"new_upload.png"] forState:UIControlStateNormal];
//    [releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [releaseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -6, -20)];
//    releaseButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [releaseButton addTarget:self action:@selector(releaseInfo:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
//    self.navigationItem.rightBarButtonItem = releaseButtonItem;
//    
//    
//    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [_leftButton setImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
//    [_leftButton addTarget:self action:@selector(doLeftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *releaseButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
//    [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(-1, -25, 0, 0)];
//    [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(-1, -25, 0, 0)];
//    
//    self.navigationItem.leftBarButtonItem = releaseButtonItem2;
    
    

    _topTextView = [[UITextView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 150 * W_Hight_Zoom)];
    _topTextView.textAlignment = NSTextAlignmentLeft;
    _topTextView.backgroundColor = [UIColor whiteColor];
    _topTextView.delegate = self;
    _topTextView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_topTextView];
    
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.text = @"  请输入内容";
    _placeholderLabel.font = _topTextView.font;
    _placeholderLabel.layer.cornerRadius = 5;
    [self.view addSubview:_placeholderLabel];
    
    
    
    _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObjectsFromArray:_choseeImage];
    
    [self addImageS];
    
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 162 * W_Hight_Zoom, 375 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    
    
    UILabel * shancghuandao = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 10 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    shancghuandao.text = @"上传到:";
    shancghuandao.textColor = [UIColor blackColor];
    shancghuandao.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:shancghuandao];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(200 * W_Wide_Zoom, 10 * W_Hight_Zoom, 163 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.text = _albumname;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:nameLabel];
    
    
    
    
}


-(void)doRightButtonTouch{
    if (_isFabu == YES) {
        return;
    }
    
    [_imageArray removeLastObject];
    if (_imageArray.count < 1) {
         [[AppUtil appTopViewController] showHint:@"请至少选择一张图片"];
        return;
    }
    
    NSMutableString * stingArr =[[NSMutableString alloc]init];
    NSDateFormatter * formater =[[NSDateFormatter alloc]init];
    NSMutableArray * dataBaseArr =[[NSMutableArray alloc]init];
    for (int i = 0 ; i < _imageArray.count; i ++) {
        NSData * dataImage = UIImageJPEGRepresentation(_imageArray[i], 0.5);
        NSString * dateBase64 =[dataImage base64EncodedStringWithOptions:0];
        [dataBaseArr addObject:dateBase64];
    }
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    [formater stringFromDate:[NSDate date]];
    
    NSString *picname1 = [NSString stringWithFormat:@"%@.jpg",[formater stringFromDate:[NSDate date]]];
    [stingArr appendString:@"["];
    for (int i = 0; i < _imageArray.count; i++) {
        NSString * picstr =[NSString stringWithFormat:@"{\"%@\":\"%@\",\"%@\":\"%@\"}",@"name",picname1,@"pic",dataBaseArr[i]];
        [stingArr appendString:picstr];
        
        if (i != _imageArray.count-1) {
            [stingArr appendString:@","];
        }
    }
    [stingArr appendString:@"]"];
    
    _isSelect = YES;
    _isFabu  = YES;
    [self showHudInView:self.view hint:@"正在发布..."];

    [[AFHttpClient sharedAFHttpClient]issueWithuserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid aid:_aidstr coneten:_topTextView.text  photos:stingArr userides:[AccountManager sharedAccountManager].loginModel.userid complete:^(BaseModel *model) {
 
        if (model) {
           // [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxinn" object:nil];
         
        }
        _isSelect = NO;
        _isFabu  = NO;
    }];

}


-(void)doLeftButtonTouch{
    if (_isSelect == YES) {
        return;
    }
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有发布内容，是否要退出？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
       // [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)addImageS{
    _bigView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 225 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    _bigView.backgroundColor = BACKGRAY_COLOR;
    [self.view addSubview:_bigView];
    [_imageArray addObject:[UIImage imageNamed:@"addImage1.png"]];
    for (int i = 0 ; i < _imageArray.count; i++) {
        _imageButtones = [[UIButton alloc]initWithFrame:CGRectMake(12.5 * W_Wide_Zoom + i * 90 * W_Wide_Zoom, 0 * W_Hight_Zoom, 80 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
        [_imageButtones setImage:_imageArray[i] forState:UIControlStateNormal];
        [_bigView addSubview:_imageButtones];
        _imageButtones.tag = i;
        [_imageButtones addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttonTouch:(UIButton *)sender{
    
    NSInteger i = _imageArray.count;
    if (i <= 1) {
     //   NSLog(@"如果删除完了，弹出来的是可以选择视频的界面");
        //  [self openDownBigView];
        [self openDownImageView];
    }else{
        if (sender.tag == i - 1 ) {
            if (_imageArray.count > 4) {
                NSLog(@"不能大于4张");
                return;
            }
            [self openDownImageView];
        }else{
            UIAlertController *  alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            //          [alert addAction:[UIAlertAction actionWithTitle:@"预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
            //              NSLog(@"预览");
            //
            //
            //          }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [sender removeFromSuperview];
                [_imageArray removeObjectAtIndex:sender.tag];
                [_bigView removeFromSuperview];
                [self paixuImageButton];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
//删除照片后重新排序
-(void)paixuImageButton{
    
    _bigView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 225 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    _bigView.backgroundColor = BACKGRAY_COLOR;
    [self.view addSubview:_bigView];
    for (int i = 0 ; i < _imageArray.count; i++) {
        _imageButtones = [[UIButton alloc]initWithFrame:CGRectMake(12.5 * W_Wide_Zoom + i * 90 * W_Wide_Zoom, 225 * W_Hight_Zoom, 80 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
        [_imageButtones setImage:_imageArray[i] forState:UIControlStateNormal];
        [self.view addSubview:_imageButtones];
        _imageButtones.tag = i;
        [_imageButtones addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)openDownBigView{
    _downWithView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 160 * W_Hight_Zoom)];
}



-(void)openDownImageView{
//    _downWithView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
//    _littleDownView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
//    _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 667 * W_Hight_Zoom)];
//    _coverButton.backgroundColor = [UIColor blackColor];
//    _coverButton.alpha = 0.4;
//    [[UIApplication sharedApplication].keyWindow addSubview:_coverButton];
//    [_coverButton addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
//    [UIView animateWithDuration:0.3 animations:^{
//        _downWithView.frame = CGRectMake(0 * W_Wide_Zoom, 540 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
//        _littleDownView.frame = CGRectMake(0 * W_Wide_Zoom, 627 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
//        _littleDownView.backgroundColor = [UIColor whiteColor];
//        _downWithView.backgroundColor = [UIColor whiteColor];
//        [[UIApplication sharedApplication].keyWindow addSubview:_littleDownView];
//        [[UIApplication sharedApplication].keyWindow addSubview:_downWithView];
//    }];
//    NSArray * nameArray = @[NSLocalizedString(@"photograph", nil),NSLocalizedString(@"photoalbum", nil)];
//    for (int i = 0; i < 2; i++) {
//        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
//        lineLabel.backgroundColor = [UIColor grayColor];
//        [_downWithView addSubview:lineLabel];
//        
//        UIButton * downButtones = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
//        [downButtones setTitle:nameArray[i] forState:UIControlStateNormal];
//        [downButtones setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        downButtones.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_downWithView addSubview:downButtones];
//        downButtones.tag = i;
//        [downButtones addTarget:self action:@selector(imageButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    UIButton * quxiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
//    [quxiaoButton setTitle:@"取消" forState:UIControlStateNormal];
//    [quxiaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    quxiaoButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_littleDownView addSubview:quxiaoButton];
//    [quxiaoButton addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
    _isSelect = YES;
    _isFabu = YES;
    _bigBtn = [[UIButton alloc]initWithFrame:self.view.frame];
    _bigBtn.backgroundColor = [UIColor blackColor];
    _bigBtn.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigBtn];
    
    _albumBtn = [[UIButton alloc]init];
    [_albumBtn setImage:[UIImage imageNamed:@"Album.png"] forState:UIControlStateNormal];
    _albumBtn.backgroundColor = [UIColor clearColor];
    [_albumBtn addTarget:self action:@selector(loacalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_albumBtn];
    [_albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_albumBtn.superview.mas_left).offset(107.5 * W_Wide_Zoom);
        make.bottom.equalTo(_albumBtn.superview.mas_bottom).offset(-154);
        make.height.width.mas_equalTo(60);
        
    }];
    
    _snapBtn = [[UIButton alloc]init];
    [_snapBtn setImage:[UIImage imageNamed:@"snap.png"] forState:UIControlStateNormal];
    _snapBtn.backgroundColor = [UIColor clearColor];
    [_snapBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
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
//-(void)hideButton:(UIButton *)sender{
//    _coverButton.hidden = YES;
//    [UIView animateWithDuration:0.3 animations:^{
//        _downWithView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
//        _littleDownView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
//    }];
//}
//
//-(void)imageButtonTouch:(UIButton *)sender{
//    if (sender.tag == 0) {
//        [self takePhoto];
//    }else{
//        [self loacalPhoto];
//    }
//    
//}

-(void)closebtnTouch{
    _isSelect = NO;
    _isFabu = NO;
    _bigBtn.hidden = YES;
    _closeBtn.hidden = YES;
    _albumBtn.hidden = YES;
    _albumLabel.hidden =YES;
    _snapBtn.hidden = YES;
    _snapLabel.hidden = YES;
   // _pushjiaBtn.hidden = NO;
    
    
}

#pragma mark - Uiimagepicker

// 拍照
- (void)takePhoto
{
    //[self hideButton:nil];
    [self closebtnTouch];
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
    //[self.navigationCo                                                                                                                                                                                                                                                                                                                                                                                                             ntroller pushViewController:_imagePicker animated:YES];
    
}



//相册选取
- (void)loacalPhoto
{
   // [self hideButton:nil];
//    NSArray * mediaTypers = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        _imagePicker.mediaTypes = @[mediaTypers[0],mediaTypers[1]];
//        _imagePicker.allowsEditing = YES;
//    }
//    [self presentViewController:_imagePicker animated:NO completion:nil];
    [self closebtnTouch];
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    picker.maxCount = 4 - _imageArray.count + 1;
    //返回选中的原图
    [picker setDidFinishSelectImages:^(NSMutableArray *images) {
        NSLog(@"原图%@",images);
        //        IssueViewController * issue = [[IssueViewController alloc]init];
        //        issue.aidstr = _aidStr;
        //        issue.choseeImage = images;
        //        [self.navigationController pushViewController:issue animated:NO];
//        SelectAlbumViewController * Vc = [[SelectAlbumViewController alloc]init];
//        Vc.choseeImage = images;
     //   [self.navigationController pushViewController:Vc animated:NO];
        
        [_imageArray removeLastObject];
        [_imageArray addObjectsFromArray:images];
        [self addImageS];
        
    }];
    [self presentViewController:picker animated:YES completion:nil];

    
    
    
    
}

//得到图片之后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_imageArray removeLastObject];
    UIImage * getImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imageArray addObject:getImage];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self addImageS];
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    _placeholderLabel.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_topTextView.text.length == 0) {
        _placeholderLabel.text = @"  请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
}
- (void)textViewDidChange:(UITextView *)textView {
     NSInteger number = [textView.text length];
    if (number > 30) {
          textView.text = [textView.text substringToIndex:30];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"字符个数不能大于30" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }



}





@end
