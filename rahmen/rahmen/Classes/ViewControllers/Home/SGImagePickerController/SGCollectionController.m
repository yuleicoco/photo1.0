//
//  SGCollectionController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/20.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGCollectionController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGAssetModel.h"
#import "SGPhotoBrowser.h"
#import "SGImagePickerController.h"
#import "SGTip.h"
#define MARGIN 10
#define COL 4
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface SGShowCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation SGShowCell

@end

@interface SGCollectionController ()
@property (nonatomic,strong) NSMutableArray *assetModels;
//选中的模型
@property (nonatomic,strong) NSMutableArray *selectedModels;
//选中的图片
@property (nonatomic,strong) NSMutableArray *selectedImages;

//底部button
@property (nonatomic,strong)UIButton * doneBtn;
@end

@implementation SGCollectionController

static NSString * const reuseIdentifier = @"Cell";
//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (kWidth - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [super initWithCollectionViewLayout:flowLayout];
}
- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}
- (NSMutableArray *)selectedImages{
    if (_selectedImages == nil) {
        _selectedImages = [NSMutableArray array];
    }
    return _selectedImages;
}
- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        SGAssetModel *model = [[SGAssetModel alloc] init];
        model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        [self.assetModels addObject:model];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[SGShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //定制左边按钮
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 15, 30);
    [leftbutton setTitleEdgeInsets:UIEdgeInsetsMake(-1, -18, 0, 0)];
    [leftbutton setImageEdgeInsets:UIEdgeInsetsMake(-1, -18, 0, 0)];
    [leftbutton setImage:[UIImage imageNamed:@"backk"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(doLeftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    
    
    
    //右侧完成按钮
//    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelecting)];
//    self.navigationItem.rightBarButtonItem = finish;
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 80, 30);
//    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -18)];
//   // [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-1, -18, 0, 0)];
//    [rightBtn setTitle:@"Select" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(finishSelecting) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitleColor:ZIYELLOW_COLOR forState:UIControlStateNormal];
//     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _doneBtn = [[UIButton alloc]init];
    _doneBtn.backgroundColor = RGB(201, 201, 201);
    [_doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    [_doneBtn addTarget:self action:@selector(finishSelecting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doneBtn];
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_doneBtn.superview);
        make.height.mas_equalTo(49);
        
    }];
    
    
    
    
}
- (void)doLeftButtonTouch{
    [self.navigationController popViewControllerAnimated:NO];
}


//出口,选择完成图片
- (void)finishSelecting{
    if (self.maxCount==4) {
        return;
    }
    
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]]) {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages) {
        
        for (SGAssetModel *model in self.assetModels) {
            if (model.isSelected) {
                [self.selectedModels addObject:model];
            }
        }
 
            //获取原始图片可能是异步的,因此需要判断最后一个,然后传出
            for (int i = 0; i < self.selectedModels.count; i++) {
                SGAssetModel *model = self.selectedModels[i];
                [model originalImage:^(UIImage *image) {
                    [self.selectedImages addObject:image];
                    
                    if ( i == self.selectedModels.count - 1) {//最后一个
                        if (picker.didFinishSelectImages) {
                            picker.didFinishSelectImages(self.selectedImages);
                        }
                        
                    }
                }];
            }
        
        if (picker.didFinishSelectThumbnails) {
            picker.didFinishSelectThumbnails([_selectedModels valueForKeyPath:@"thumbnail"]);
        }
        
        }
    }
    
    //移除
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.assetModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SGAssetModel *model = self.assetModels[indexPath.item];
   
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil) {//防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"red_normal.png"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"red_seleted.png"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - 27, 2, 25, 25);
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    return cell;
}
- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    SGAssetModel *model = self.assetModels[sender.tag];
    //因为重用的问题,不能根据选中状态来记录
    if (sender.selected == YES) {//选中了记录
        if (self.maxCount <= 0) {
           [[AppUtil appTopViewController] showHint:@"您最多只能选择4张图片"];
            sender.selected = NO;
        }else{
         model.isSelected = YES;
            self.maxCount--;
        }
    }else{//否则移除记录
        model.isSelected = NO;
        self.maxCount++;
    }
    
    NSInteger i = 4 - self.maxCount;
    if ( i > 0) {
        _doneBtn.backgroundColor = ZIYELLOW_COLOR;
        [_doneBtn setTitle:[NSString stringWithFormat:@"Done%ld/%d",i,4] forState:UIControlStateNormal];
    }else{
        _doneBtn.backgroundColor = RGB(201, 201, 201);
        [_doneBtn setTitle:@"Done"forState:UIControlStateNormal];
        
    }
    
 
}








#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SGPhotoBrowser *browser = [[SGPhotoBrowser alloc] init];
    browser.assetModels = self.assetModels;
    browser.currentIndex = indexPath.item;
    [browser show];
}
@end
