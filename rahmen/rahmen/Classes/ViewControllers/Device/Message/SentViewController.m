//
//  SentViewController.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "SentViewController.h"
#import "MessageTableViewCell.h"
#import "AFHttpClient+Devices.h"

static NSString * cellId = @"MessageTableViewCellId2";
@interface SentViewController ()

@end

@implementation SentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Sent"];
}
-(void)setupView{
    [super setupView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview);
        make.left.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(self.tableView.superview.height);
    }];
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];
    

    
}
-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]getNewMsgWithUserid:[AccountManager sharedAccountManager].loginModel.userid type:@"sent" page:[NSString stringWithFormat:@"%d",page] complete:^(BaseModel *model) {
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


-(void)setupData{
    [super setupData];
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
    return 70;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    NewmessageModel * model = self.dataSource[indexPath.row];
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    NSString * headStr = model.headportrat;
    NSURL * headUrl = [NSURL URLWithString:headStr];
    [cell.headImage sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"morentouxiang.png"]];
    cell.nameLabel.text = model.nickname;
    if ([model.type isEqualToString:@"r"]) {
        cell.inOrquestLabel.text = @"Request:";
    }else{
        cell.inOrquestLabel.text = @"Invite:";
    }
    cell.deveicemarkeLabel.text = model.deviceno;
    if ([model.status isEqualToString:@"0"]) {
        cell.rejectBtn.hidden = YES;
        cell.AcceptBtn.hidden = YES;
        cell.rightLabel.hidden = NO;
        cell.rightLabel.text = @"Rejected";
    }else if ([model.status isEqualToString:@"1"]){
        cell.rejectBtn.hidden = YES;
        cell.AcceptBtn.hidden = YES;
        cell.rightLabel.hidden = NO;
        cell.rightLabel.text = @"Accepted";
    }else if ([model.status isEqualToString:@"2"]){
        cell.rejectBtn.hidden = YES;
        cell.AcceptBtn.hidden = YES;
        cell.rightLabel.hidden = NO;
        cell.rightLabel.text = @"Watting";
    }
    

    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






@end
