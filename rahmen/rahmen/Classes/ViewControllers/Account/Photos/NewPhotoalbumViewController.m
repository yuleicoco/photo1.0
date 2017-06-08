//
//  NewPhotoalbumViewController.m
//  sebot
//
//  Created by czx on 16/6/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewPhotoalbumViewController.h"
#import "NewAlbumModel.h"
#import "AFHttpClient+Test.h"
#import "IssueViewController.h"
#import "SGImagePickerController.h"
#import "NewPhotoCollectionViewCell.h"
#import "AlbumPhotosViewController.h"
#import "NewAlbumViewController.h"

@interface NewPhotoalbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)NSMutableArray * datasouce;
@property (nonatomic,strong) UICollectionView *colView;

@property (nonatomic,strong)UIView * downView;
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * downwitheView;

@property(nonatomic,strong)UIImagePickerController * imagePicker;

@property (nonatomic,strong)NSString * aidStr;

@property (nonatomic,assign)BOOL isselect;
@property (nonatomic,strong)UIButton * deleteBtn;
@property (nonatomic,strong)NSMutableArray * deleArray;

@end

@implementation NewPhotoalbumViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUserface];
    [self request];
    _isselect = NO;
    [self showBarButton:NAV_RIGHT title:@"Select" fontColor:ZIYELLOW_COLOR hide:NO];
    
    
    
}
-(void)doRightButtonTouch{
    _isselect = !_isselect;
    [_deleArray removeAllObjects];
    if (_isselect == YES) {
          [self showBarButton:NAV_RIGHT title:@"Cancel" fontColor:ZIYELLOW_COLOR hide:NO];
        _deleteBtn.hidden = NO;
        _colView.frame= CGRectMake(0 * W_Wide_Zoom , 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 550 * W_Hight_Zoom );
    }else{
          [self showBarButton:NAV_RIGHT title:@"Select" fontColor:ZIYELLOW_COLOR hide:NO];
        _deleteBtn.hidden = YES;
        _colView.frame= CGRectMake(0 * W_Wide_Zoom , 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 600 * W_Hight_Zoom );
    }
    
    [_colView reloadData];
    

}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"选择相册"];
    _deleArray = [[NSMutableArray alloc]init];
    _datasouce  = [NSMutableArray array];
   // [UINavigationBar appearance].barTintColor=RED_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
 
    
}
-(void)request{
    //查询接口
    [self.datasouce removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]newphotoWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(BaseModel *model) {
        if (model.list.count > 0) {
            for (NewAlbumModel * albumModel in model.list) {
                albumModel.aidArray = [albumModel.aid componentsSeparatedByString:@","];
            }
            
            NSArray * array = model.list;
            [self.datasouce addObject:array[0]];
            [self.datasouce addObjectsFromArray:model.list];
            [_colView reloadData];
        }else{
            //这里写一个就行了
            //如果数组是空的，就造一个，让那个加号建显示出来就行了
            NSArray * array = @[@{@"aid":@"",@"albumname":@"",@"cover":@"",@"did":@"",@"photonum":@"",@"userid":@""}];
            [self.datasouce addObjectsFromArray:array];
            [_colView reloadData];
        
        }
       
    }];
}

-(void)initUserface{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _colView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 * W_Wide_Zoom , 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 600 * W_Hight_Zoom ) collectionViewLayout:layout];
    [_colView registerClass:[NewPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _colView.backgroundColor = [UIColor whiteColor];
    _colView.delegate = self;
    _colView.dataSource = self;
    [self.view addSubview:_colView];
    
    _deleteBtn = [[UIButton alloc]init];
    _deleteBtn.backgroundColor = RGB(234, 234, 234);
    _deleteBtn.userInteractionEnabled = NO;
    [_deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deleteBtn.superview);
        make.right.equalTo(_deleteBtn.superview);
        make.bottom.equalTo(_deleteBtn.superview);
        make.height.mas_equalTo(50);
    }];
    
    _deleteBtn.hidden = YES;

    
}

//配置UICollectionView的每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

  
    return self.datasouce.count;
    
}
//配置section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//呈现数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NewAlbumModel * model = self.datasouce[indexPath.row];
    static NSString *cellID = @"myCell";
    NewPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //我的妈，改死个人了，先删除一下，不然会重用
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }

    if (indexPath.row < 1) {
//        UIView * whiteView = [[UIView alloc]initWithFrame:cell.bounds];
//        whiteView.backgroundColor = [UIColor whiteColor];
//        [cell.contentView addSubview:whiteView];
//        
//        UIImageView * centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(whiteView.frame) + 30, CGRectGetMinY(whiteView.frame) + 20, 50 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
//        centerImage.image = [UIImage imageNamed:@"addImage11.png"];
//        [whiteView addSubview:centerImage];
//        
//        UILabel * newAlubmLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(whiteView.frame) + 30, CGRectGetMaxY(centerImage.frame) + 5 ,200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
//        //newAlubmLabel.backgroundColor = [UIColor blackColor];
//        newAlubmLabel.text = @"新建相册";
//        newAlubmLabel.textColor = [UIColor blackColor];
//        newAlubmLabel.font = [UIFont systemFontOfSize:13];
//        [whiteView addSubview:newAlubmLabel];
//        
//
        cell.mengcengView.hidden = YES;
        cell.rightBtn.hidden = YES;
        cell.nameLabel.hidden = YES;
        cell.numberLabel.hidden = YES;
        [cell.backImage setImage:[UIImage imageNamed:@"addImage11.png"]];
        
    }else{
        if (_isselect == YES) {
            cell.rightBtn.hidden = NO;
        }else{
            cell.rightBtn.hidden = YES;
        }
        if (_deleArray.count==0) {
            cell.rightBtn.selected = NO;
        }
        cell.mengcengView.hidden = NO;
        cell.nameLabel.hidden = NO;
        cell.numberLabel.hidden = NO;
       // [cell.backImage setImage:[UIImage imageNamed:@"albummorenren.png"]];
        
        NSArray * array = [model.cover componentsSeparatedByString:@","];
        if (array.count > 0) {
            NSString * imageStr = [NSString stringWithFormat:@"%@",array[0]];
            NSURL * imageUrl = [NSURL URLWithString:imageStr];
            [cell.backImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"albummorenren.png"]];
        }else{
            [cell.backImage setImage:[UIImage imageNamed:@"albummorenren.png"]];
        }
        cell.nameLabel.text = model.albumname;
        cell.numberLabel.text = model.photonum;
        
    }
   
    
    return cell;
}

//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return CGSizeMake(110 * W_Wide_Zoom, 110 * W_Hight_Zoom);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
     return UIEdgeInsetsMake(13, 11 , 0, 11);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewAlbumModel * model = self.datasouce[indexPath.row];
    //   NewPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NewPhotoCollectionViewCell *cell = (NewPhotoCollectionViewCell *)[_colView cellForItemAtIndexPath:indexPath];
    
    if (_isselect == NO) {
        if (indexPath.row == 0) {
            NewAlbumViewController * newAlbumVc =[[NewAlbumViewController alloc]init];
            [self.navigationController pushViewController:newAlbumVc animated:NO];
            
        }else{
            AlbumPhotosViewController * albumVc = [[AlbumPhotosViewController alloc]init];
            albumVc.didstr = model.aid;
            [self.navigationController pushViewController:albumVc animated:NO];
            
        }
        
        
    }else{
    NSLog(@"您点击了item:%ld",indexPath.row);
     //static NSString *cellID = @"myCell";
        if (indexPath.row == 0) {
            return;
        }
        

 //   cell.rightBtn.selected = !cell.rightBtn.selected;
    if (cell.rightBtn.selected == YES) {
        [_deleArray removeObject:model.aid];
        cell.rightBtn.selected = NO;
    }else{
        [_deleArray addObject:model.aid];
        cell.rightBtn.selected = YES;
    }
    
    }
    if (_deleArray.count <= 0) {
        _deleteBtn.backgroundColor = RGB(234, 234, 234);
        _deleteBtn.userInteractionEnabled = NO;
    }else{
        _deleteBtn.backgroundColor = ZIYELLOW_COLOR;
        _deleteBtn.userInteractionEnabled = YES;
    }
    
    
    
//    if (indexPath.row < 1) {
//        NewInformationViewController * haha = [[NewInformationViewController alloc]init];
//        [self.navigationController pushViewController:haha animated:NO];
//    }else{
//        NewAlbumModel * model = self.datasouce[indexPath.row];
//        _aidStr = model.aid;
//        NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
//        [userdefaults setObject:model.albumname forKey:@"albuumname"];
//        
//        [self downButttonUp];
//        
//    }
    

}

//
//- (void)onVideo:(UITapGestureRecognizer *)imageSender
//{
//    NSInteger i = imageSender.view.tag/1000;//分区
//    int j = imageSender.view.tag%1000;//每个分区的分组  因为多了一条默认的数据，要减去1
//
//    NewAlbumModel *model = self.datasouce[i - 1];
//    NSArray *imageA  = model.aidArray;
//    NewPhotoCollectionViewCell *cell = (NewPhotoCollectionViewCell *)[_colView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
//    cell.rightBtn.selected = !cell.rightBtn.selected;
//    if (cell.rightBtn.selected == YES) {
//       // cell.rightBtn.selected = NO;
//        [_deleArray removeObject:imageA[j - 1]];
//    }else{
//       // cell.selected = YES;
//        [_deleArray addObject:imageA[j - 1]];
//    }
//    
//    
//    
//
//}
-(void)deleteButtonTouch{
    
    NSMutableString * str = [[NSMutableString alloc]init];
    NSString *deleStr = [NSString stringWithFormat:@"%@",_deleArray[0]];
    [str appendFormat:@"%@",str];
    str =[NSMutableString stringWithFormat:@"'%@'",deleStr];
    
    for (int i = 1 ; i < _deleArray.count; i++) {
        NSString * delestr = [NSString stringWithFormat:@"%@",_deleArray[i]];
        [str appendFormat:@",'%@'",delestr];
    }
    
    
    
  [[AFHttpClient sharedAFHttpClient]delePhoto:[AccountManager sharedAccountManager].loginModel.userid token:@"" aid:str complete:^(BaseModel *model) {
      if (model) {
          [[AppUtil appTopViewController]showHint:model.retDesc];
          [self request];
          
      }
      [self doRightButtonTouch];
  }];


}


@end
