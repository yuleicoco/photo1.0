//
//  SelectAlbumViewController.m
//  rahmen
//
//  Created by czx on 2017/6/4.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "SelectAlbumViewController.h"
#import "SelectalbumTableViewCell.h"
#import "AFHttpClient+MyPhoto.h"
#import "NewAlbumModel.h"
#import "IssueViewController.h"
static NSString * cellId = @"selectalbumtabviewCellid";
@interface SelectAlbumViewController ()
@property (nonatomic,strong)NSMutableArray * rightArray;
@property (nonatomic,strong)NSMutableArray * nameArray;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行
@end

@implementation SelectAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Select the album"];
    _rightArray = [[NSMutableArray alloc]init];
    _nameArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height);
    [self.tableView registerClass:[SelectalbumTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self showBarButton:NAV_RIGHT title:@"Next" fontColor:ZIYELLOW_COLOR hide:NO];
    
}
-(void)doRightButtonTouch{
    if (_rightArray.count<=0) {
        [[AppUtil appTopViewController]showHint:@"请选择一个相册哦"];
    }else{
        IssueViewController * issue = [[IssueViewController alloc]init];
        issue.choseeImage = _choseeImage;
        issue.aidstr = _rightArray[0];
        issue.albumname = _nameArray[0];
        [self.navigationController pushViewController:issue animated:NO];
        
    }



}



-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]QueryMyPhoto:[AccountManager sharedAccountManager].loginModel.userid token:@"" complete:^(BaseModel * model) {
        if (model) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
            [self.tableView reloadData];
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
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewAlbumModel * model = self.dataSource[indexPath.row];
    SelectalbumTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }else{
        cell.lineLabel.hidden = NO;
    }
    cell.nameLabel.text = model.albumname;
    NSArray *Array = [model.cover componentsSeparatedByString:@","];
    if (Array.count > 0) {
        [cell.secoendImage sd_setImageWithURL:Array[0] placeholderImage:[UIImage imageNamed:@"默认图片.png"]];
        [cell.firstImage sd_setImageWithURL:Array[1] placeholderImage:[UIImage imageNamed:@"默认图片.png"]];
    }else{
        [cell.secoendImage setImage:[UIImage imageNamed:@"默认图片"]];
         [cell.firstImage setImage:[UIImage imageNamed:@"默认图片"]];
    }
    
    
    [_rightArray removeAllObjects];
    cell.rightBtn.tag = indexPath.row + 22;
    cell.rightBtn.selected = NO;
    [cell.rightBtn addTarget:self action:@selector(rightButtonTouch:)    forControlEvents:UIControlEventTouchUpInside];
    

    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    
}




-(void)rightButtonTouch:(UIButton *)sender{
   
    
    NSInteger i =sender.tag -22;
     NewAlbumModel * model = self.dataSource[i];
    //NSString * str = [NSString stringWithFormat:@"%ld",i];
    if (sender.selected == NO) {
        if (_rightArray.count >= 1) {
            [[AppUtil appTopViewController]showHint:@"您只能选择一个相册发布"];
            return;
        }
        sender.selected = YES;
        [_rightArray addObject:model.aid];
        [_nameArray addObject:model.albumname];
        
    }else{
        sender.selected = NO;
        [_rightArray removeObject:model.aid];
        [_nameArray removeObject:model.albumname];
    }
  
    
    

}





@end
