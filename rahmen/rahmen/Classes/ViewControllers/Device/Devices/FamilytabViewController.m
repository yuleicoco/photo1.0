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

@end

@implementation FamilytabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Family"];
    _isguanli = NO;
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
        }else{
            _isguanli = YES;
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
