//
//  NewAlbumViewController.m
//  rahmen
//
//  Created by czx on 2017/6/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "NewAlbumViewController.h"
#import "AlbumphotoTableViewCell.h"
#import "AFHttpClient+Test.h"
#import "NewAlbumAdviceModel.h"

static NSString * cellId = @"AlbumphotoTableViewCellId";
@interface NewAlbumViewController ()
@property (nonatomic,strong)UITextField * nameTextfield;
@property (nonatomic,strong)NSMutableArray * didsArray;

@end

@implementation NewAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGRAY_COLOR;
    _didsArray = [[NSMutableArray alloc]init];
    [self setNavTitle:@"New Album"];
    [self showBarButton:NAV_RIGHT title:@"Ok" fontColor:ZIYELLOW_COLOR hide:NO];
    
}
-(void)doRightButtonTouch{
    if (_didsArray.count<=0) {
        [[AppUtil appTopViewController]showHint:@"请至少选择一个设备"];
        return;
    }
    if ([AppUtil isBlankString:_nameTextfield.text]) {
        [[AppUtil appTopViewController]showHint:@"请输入相册名称"];
        return;
    }
    
    NSString * didstr = [_didsArray componentsJoinedByString:@","];
    
    [[AFHttpClient sharedAFHttpClient]addablumWithalbumname:_nameTextfield.text userid:[AccountManager sharedAccountManager].loginModel.userid dids:didstr complete:^(BaseModel *model) {
        if (model) {
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    }];
    
    
    

}



-(void)setupView{
    [super setupView];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(topView.superview);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"Name:";
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.font = [UIFont systemFontOfSize:17.5];
    [self.view addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabel.superview.mas_left).offset(16);
        make.centerY.equalTo(topView.mas_centerY);
        
    }];
    
    _nameTextfield = [[UITextField alloc]init];
    _nameTextfield.placeholder = @"请输入相册名称";
    _nameTextfield.textColor = [UIColor blackColor];
    _nameTextfield.font = [UIFont systemFontOfSize:17.5];
    [_nameTextfield setValue:PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _nameTextfield.tintColor = ZIYELLOW_COLOR;
    [self.view addSubview:_nameTextfield];
    [_nameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nameTextfield.superview);
        make.left.equalTo(leftLabel.mas_right).offset(5);
        make.centerY.equalTo(topView.mas_centerY);
        make.height.mas_equalTo(50);
      
    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(4);
        make.left.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(self.tableView.superview.height - topView.height - 4);
    }];
    [self.tableView registerClass:[AlbumphotoTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
    
}
-(void)setupData{
    [super setupData];
     [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]testWithuserid:[AccountManager sharedAccountManager].loginModel.userid token:@"" complete:^(BaseModel *model) {
        if (model) {
            if (model.list.count > 0) {
                NSArray * array = model.list;
                [self.dataSource addObject:array[0]];
                [self.dataSource addObjectsFromArray:model.list];
                [self.tableView reloadData];
            }else{

                NSArray * array = @[@{@"aid":@"",@"albumname":@"",@"chose":@"",@"deviceremark":@"",@"did":@""}];
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];

            }
//            [self.dataSource addObjectsFromArray:model.list];
//            [self.tableView reloadData];
        }
        
    }];
    
    
}

-(void)initTabview{

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
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewAlbumAdviceModel * model = self.dataSource[indexPath.row];
    AlbumphotoTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
        cell.leftLabel.text = @"Change the visibility";
        cell.rightBtn.hidden = YES;
    }else{
        cell.lineLabel.hidden = NO;
        cell.leftLabel.text = model.deviceremark;
        cell.rightBtn.hidden = NO;
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NewAlbumAdviceModel * model = self.dataSource[indexPath.row];
    AlbumphotoTableViewCell *cell = (AlbumphotoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
   // cell.rightBtn.selected = !cell.rightBtn.selected;
    if (cell.rightBtn.selected == NO) {
        [_didsArray addObject:model.did];
        cell.rightBtn.selected = YES;
    }else{
        [_didsArray removeObject:model.did];
        cell.rightBtn.selected = NO;
    }
    

}









@end
