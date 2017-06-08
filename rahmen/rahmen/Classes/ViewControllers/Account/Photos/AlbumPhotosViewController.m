//
//  AlbumPhotosViewController.m
//  rahmen
//
//  Created by czx on 2017/6/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AlbumPhotosViewController.h"
#import "MyVideoCollectionViewCell.h"
#import "AFHttpClient+MyPhoto.h"
#import "AlbumSettingViewController.h"
#import "LargeViewController.h"

static NSString *kfooterIdentifier = @"footerIdentifier";
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kRecordheaderIdentifier = @"RecordHeaderIdentifier";
@interface AlbumPhotosViewController ()
@property (nonatomic,strong)UIButton * bitBtn;
@property (nonatomic,strong)UIView * whiteView;
@property (nonatomic,strong)UIButton * deleBtn;
@property (nonatomic,strong)UIButton * settingBtn;

@property (nonatomic,assign)BOOL isBig;
@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSMutableArray * deletArray;

@property (nonatomic,strong)UIButton * bottomBtn;
@end

@implementation AlbumPhotosViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bigButtonTouch];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavTitle:@"Photos"];
    _isBig = NO;
    _isSelect = NO;
    _deletArray = [[NSMutableArray alloc]init];
    [self showBarButton:NAV_RIGHT imageName:@"point.png" hide:NO];
    
}
-(void)doRightButtonTouch{
    if (_isSelect == YES) {
        _isSelect = NO;
        [self showBarButton:NAV_RIGHT imageName:@"point.png" hide:NO];
        //刷新contab 数组清空
        _bottomBtn.hidden = YES;
        [_deletArray removeAllObjects];
        [self.collectionView reloadData];
        return;
    }
    
    
    if (_isBig == NO) {
        _bitBtn = [[UIButton alloc]init];
        _bitBtn.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bitBtn];
        [_bitBtn addTarget:self action:@selector(bigButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        [_bitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(_bitBtn.superview);
        }];
        
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_whiteView];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_whiteView.superview.mas_right).offset(-12);
            make.top.equalTo(_whiteView.superview.mas_top);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(80.5);
            
        }];
        
        UILabel * lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = FENLINE_COLOR;
        [_whiteView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(lineLabel.superview);
            make.centerY.equalTo(lineLabel.superview);
            make.height.mas_equalTo(0.5);
            
        }];
        
        _deleBtn = [[UIButton alloc]init];
        [_deleBtn setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        _deleBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
        [_whiteView addSubview:_deleBtn];
        [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_deleBtn.superview);
            make.height.mas_equalTo(40);
            
        }];
        
        _settingBtn = [[UIButton alloc]init];
        [_settingBtn setTitle:@"Setting" forState:UIControlStateNormal];
        [_settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(settingButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
        [_whiteView addSubview:_settingBtn];
        [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_settingBtn.superview);
            make.height.mas_equalTo(40);
            
        }];
        
        _isBig = YES;
    }else{
        
        [self bigButtonTouch];
       // _isBig = NO;
    }
   


    
    
    

}

-(void)bigButtonTouch{
    _isBig = NO;
    _bitBtn.hidden = YES;
    _whiteView.hidden = YES;

}
-(void)deleButtonTouch{
    [self bigButtonTouch];
    _isSelect = YES;
    _bottomBtn.hidden = NO;
    [self showBarButton:NAV_RIGHT title:@"Cancel" fontColor:ZIYELLOW_COLOR hide:NO];
     [self.collectionView reloadData];
    
    
    
}

//删除照片
-(void)bottomBtntouch{
    NSMutableString * str = [[NSMutableString alloc]init];
    NSString *deleStr = [NSString stringWithFormat:@"%@",_deletArray[0]];
    [str appendFormat:@"%@",str];
    str =[NSMutableString stringWithFormat:@"'%@'",deleStr];
    
    for (int i = 1 ; i < _deletArray.count; i++) {
        NSString * delestr = [NSString stringWithFormat:@"%@",_deletArray[i]];
        [str appendFormat:@",'%@'",delestr];
    }
    


    [[AFHttpClient sharedAFHttpClient]Deletephoto:[AccountManager sharedAccountManager].loginModel.userid token:@"" pids:str complete:^(BaseModel *model) {
        [self initRefreshView];
        [self doRightButtonTouch];
        
    }];
    
    
    
}


-(void)settingButtonTouch{
    AlbumSettingViewController * settingVc = [[AlbumSettingViewController alloc]init];
    settingVc.aidStr = _didstr;
    [self.navigationController pushViewController:settingVc animated:NO];

}



-(void)setupView{
    [super setupView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView.superview);
        make.right.equalTo(self.collectionView.superview);
        make.top.equalTo(self.collectionView.superview.mas_top);
        make.bottom.equalTo(self.collectionView.superview.mas_bottom).offset(-60);
        
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    [self.collectionView registerClass:[MyVideoCollectionViewCell class] forCellWithReuseIdentifier:@"imageId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordHeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecordheaderIdentifier];
    
    self.collectionView.backgroundColor =[UIColor whiteColor];
    
    _bottomBtn = [[UIButton alloc]init];
    _bottomBtn.backgroundColor = RGB(234, 234, 234);
    _bottomBtn.userInteractionEnabled = NO;
    [_bottomBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomBtn addTarget:self action:@selector(bottomBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomBtn];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomBtn.superview);
        make.right.equalTo(_bottomBtn.superview);
        make.bottom.equalTo(_bottomBtn.superview);
        make.height.mas_equalTo(50);
    }];
    
    _bottomBtn.hidden = YES;
    
    
    [self initRefreshView];


}

-(void)loadDataSourceWithPage:(int)page{
    
    [[AFHttpClient sharedAFHttpClient]QueryMyPhotos:[AccountManager sharedAccountManager].loginModel.userid token:@"" did:_didstr page:[NSString stringWithFormat:@"%d",page] complete:^(BaseModel *model) {
        if (model) {
            if (page == START_PAGE_INDEX) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObject:[[PhotoGrapgModel alloc] init]];
            }
            
            for (PhotoGrapgModel * photoModel in model.list) {
                photoModel.networkaddressArray = [photoModel.networkaddress componentsSeparatedByString:@","];
                photoModel.imagenameArray = [photoModel.photoname componentsSeparatedByString:@","];
                //   recordModel.typeArray = [recordModel.type componentsSeparatedByString:@","];
                photoModel.pidArray = [photoModel.pid componentsSeparatedByString:@","];
            }
            
            if (model.list.count == 0) {
                self.collectionView.mj_footer.hidden = YES;
            }else{
                if (model.list.count<7) {
                    self.collectionView.mj_footer.hidden = YES;
                }else{
                    self.collectionView.mj_footer.hidden = NO;
                }
                
            }
            
            
            [self.dataSource addObjectsFromArray:model.list];
            
        }
        
        [self handleEndRefresh];
        [self.collectionView reloadData];
        

            
            
            
    }];




}

#pragma Mark  --- collectionDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    PhotoGrapgModel *model = self.dataSource[section];
    
    return model.imagenameArray.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //   return CGSizeMake((collectionView.width - 4 * 10 ) / 4 , (collectionView.width - 4 * 10 ) / 4);
    //  return CGSizeMake(88.5 * W_Wide_Zoom, 85.5 * W_Hight_Zoom);
    //  return CGSizeMake(110 * W_Wide_Zoom, 110 * W_Hight_Zoom);
    //  return CGSizeMake(MainScreen.width/5+5, MainScreen.width/5+5);
    return CGSizeMake((collectionView.width - 4 * 10 ) / 4 , (collectionView.width - 4 * 10 ) / 4);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5,5);
    //return UIEdgeInsetsMake(13, 11 , 0, 11);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return nil;
    }
    
    PhotoGrapgModel *model = self.dataSource[indexPath.section];
    
    MyVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.networkaddressArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"albummoren.png"]];
    
  //  cell.imageV.backgroundColor = [UIColor blackColor];
    cell.imageV.tag = 1000*(indexPath.section+1) +indexPath.row;
    cell.imageV.userInteractionEnabled = YES;
    
    //    if ([model.typeArray[indexPath.row] isEqualToString:@"video"]) {
    //  cell.startImageV.hidden = NO;
    //    }else{
    //        cell.startImageV.hidden = YES;
    //    }
    
    
    UITapGestureRecognizer * tapMYP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onVideo:)];
    [cell.imageV addGestureRecognizer:tapMYP];
    if (_isSelect == NO) {
         cell.rightBtn.hidden = YES;
    }else{
         cell.rightBtn.hidden = NO;
    }
   
    
    
    return cell;
}


//头部
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size;
    
    if (section == 0) {
        size = CGSizeMake(self.collectionView.width, 0 * W_Hight_Zoom);
    }else {
        size = CGSizeMake(self.collectionView.width, 20);
    }
    
    return size;
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size ;
    
    if (section == 0) {
        size = CGSizeZero;
    }else{
        size = CGSizeMake(self.collectionView.width, 0);
    }
    
    return size;
}

// heder和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    UICollectionReusableView *view;
    
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
        view = [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        //        UILabel *label = (UILabel *)[view viewWithTag:1111];
        view.backgroundColor =[UIColor whiteColor];
        //  label.backgroundColor =[UIColor redColor];
    }else{
        reuseIdentifier = kheaderIdentifier;
        view = [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        UILabel *label = (UILabel *)[view viewWithTag:2222];
        
        view.backgroundColor =[UIColor whiteColor];
        
        PhotoGrapgModel *model = self.dataSource[indexPath.section];
        
        label.text = model.createtime;
    }
    
    return view;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    
//   // cell.imageV.hidden = YES;
////    cell.startImageV.hidden = YES;
//    //[self.collectionView reloadData];
////    FuckLog(indexPath);
//    cell.rightBtn.selected = !cell.rightBtn.selected;
//    
//    
//    NSLog(@"%ld",indexPath.section);
//
//
//
//}

- (void)onVideo:(UITapGestureRecognizer *)imageSender
{
    // MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    
    NSInteger i = imageSender.view.tag/1000;//分区
    int j = imageSender.view.tag%1000;//每个分区的分组
     PhotoGrapgModel *model = self.dataSource[i - 1];
    NSArray * pidArray = model.pidArray;
     MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
//    cell.rightBtn.selected = !cell.rightBtn.selected;
//    NSLog(@"%d",j);
    if (_isSelect == NO) {
        LargeViewController * largeVC =[[LargeViewController alloc]initWithNibName:@"LargeViewController" bundle:nil];
        largeVC.dataArray = model.networkaddressArray;
        [self.navigationController pushViewController:largeVC animated:NO];

    }else{
    
    if (cell.rightBtn.selected == NO) {
        [_deletArray addObject:pidArray[j]];
        cell.rightBtn.selected = YES;
    }else{
        [_deletArray removeObject:pidArray[j]];
        cell.rightBtn.selected = NO;
    }
    
    }

    if (_deletArray.count <= 0) {
        _bottomBtn.backgroundColor = RGB(234, 234, 234);
        _bottomBtn.userInteractionEnabled = NO;
    }else{
        _bottomBtn.backgroundColor = ZIYELLOW_COLOR;
        _bottomBtn.userInteractionEnabled = YES;
    }
    
}




@end
