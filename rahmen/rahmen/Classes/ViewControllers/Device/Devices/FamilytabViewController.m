//
//  FamilytabViewController.m
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "FamilytabViewController.h"
#import "AFHttpClient+Devices.h"
#import "FamilyTableViewCell.h"
#import "MyfamilymemberModel.h"

static NSString * cellId = @"FamilyTableViewCellIddddd";
@interface FamilytabViewController ()
@property (nonatomic,assign)BOOL isguanli;

@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * centerView;
@property (nonatomic,strong)UITextField * numBerTextField;
@property (nonatomic,assign)BOOL isAdd;
@end

@implementation FamilytabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Family"];
    _isguanli = NO;
    _isAdd = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)setupView{
    [super setupView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview);
        make.left.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(self.tableView.superview);
    }];
    [self.tableView registerClass:[FamilyTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


-(void)setupData{
    [super setupData];
    [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]queryFamilyMemberWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didStr complete:^(BaseModel *model) {
        if (model) {
            if (model.list.count <= 0 ) {
                //这里要做没有数据的处理
            }
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
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyfamilymemberModel * model = self.dataSource[indexPath.row];
    FamilyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
        cell.rightImage.hidden = NO;
        if (![model.userid isEqualToString:[AccountManager sharedAccountManager].loginModel.userid]) {
            _isguanli = NO;
             [self showBarButton:NAV_RIGHT title:@"Add" fontColor:ZIYELLOW_COLOR hide:YES];
        }else{
            _isguanli = YES;
            [self showBarButton:NAV_RIGHT title:@"Add" fontColor:ZIYELLOW_COLOR hide:NO];
        }
    }else{
        cell.lineLabel.hidden = NO;
        cell.rightImage.hidden = YES;
    }
    NSString * headStr = model.headportrait;
    NSURL * headUrl = [NSURL URLWithString:headStr];
    [cell.headImage sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"morentouxiang.png"]];
    cell.nameLabel.text = model.nickname;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)doRightButtonTouch{
    if (_isAdd == YES) {
        return;
    }
    [self bangdingView];
    
}

-(void)bangdingView{
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

-(void)saveBtntouch{
        [[AFHttpClient sharedAFHttpClient]inviteRequestWithUserid:[AccountManager sharedAccountManager].loginModel.userid phone:_numBerTextField.text deviceno:_devinoStr complete:^(BaseModel *model) {
            if (model) {
                [self xiaoshidianji];
            }
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






- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isguanli == NO) {
        return NO;
    }else{
    if (indexPath.row == 0) {
        return NO;
    }else{
        return YES;
    
    }
    }
}

//// 定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}



//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //UITableViewRowAction是iOS8才有的，title不想要打了空格占着大小
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击删除");
//    }];
//    
//    UITableViewRowAction *shareRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击分享");
//    }];
//    
//    // 这个地方：先加入的在右边
//    return @[shareRowAction, deleteRowAction];
//}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
//

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyfamilymemberModel * model = self.dataSource[indexPath.row];
    
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@" Admin" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        //这里面写button点击之后的事件
//        [self.dataArray removeObjectAtIndex:indexPath.row];//这里的dataArray是可变数组，滑动删除的时候，需要删除数组中的元素
//        [self.test deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self transferWithuserid:model.userid];
        
    }];
    deleteRoWAction.backgroundColor = ZIYELLOW_COLOR;
    
    UITableViewRowAction *test = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        [self removesomebodyWithuserid:model.userid];
        
    }];
    test.backgroundColor = RGB(243, 127, 89);
    return @[deleteRoWAction,test];//最后返回这俩个RowAction 的数组
}


//移除用户
-(void)removesomebodyWithuserid:(NSString *)userid{
    [[AFHttpClient sharedAFHttpClient]removesomebodyWithUserid:userid admin:[AccountManager sharedAccountManager].loginModel.userid did:_didStr complete:^(BaseModel *model) {
        if (model) {
            [self setupData];
        }
    }];
    


}

//转让管理员权限
-(void)transferWithuserid:(NSString *)userid{
        [[AFHttpClient sharedAFHttpClient]transfersomebodyWithUserid:userid admin:[AccountManager sharedAccountManager].loginModel.userid did:_didStr complete:^(BaseModel *model) {
            if (model) {
                [self setupData];
            }
            
        }];

}















@end
