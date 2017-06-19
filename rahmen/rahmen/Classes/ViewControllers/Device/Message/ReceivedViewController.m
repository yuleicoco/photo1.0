//
//  ReceivedViewController.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ReceivedViewController.h"
#import "MessageTableViewCell.h"
#import "AFHttpClient+Devices.h"

static NSString * cellId = @"MessageTableViewCellId1";
@interface ReceivedViewController ()

@end

@implementation ReceivedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"Received"];
    
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
    
    [[AFHttpClient sharedAFHttpClient]getNewMsgWithUserid:[AccountManager sharedAccountManager].loginModel.userid type:@"received" page:[NSString stringWithFormat:@"%d",page] complete:^(BaseModel *model) {
        if (model) {
            [self isReadmessage];
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

-(void)isReadmessage{
    [[AFHttpClient sharedAFHttpClient]setNewMsgIsReadWithUserid:[AccountManager sharedAccountManager].loginModel.userid type:@"received" complete:^(BaseModel *model) {
        if (model) {
            
        }
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
        cell.rejectBtn.hidden = NO;
        cell.AcceptBtn.hidden = NO;
        cell.rightLabel.hidden = YES;
        //cell.rightLabel.text = @"Rejected";
    }
    cell.rejectBtn.tag = indexPath.row + 210;
    [cell.rejectBtn addTarget:self action:@selector(rejectButtontouch:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.AcceptBtn.tag = indexPath.row + 220;
    [cell.AcceptBtn addTarget:self action:@selector(acceptButtontouch:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)rejectButtontouch:(UIButton *)sender{
     NSInteger i =sender.tag - 210;
    NewmessageModel * model = self.dataSource[i];
    NSString * str = model.type;
    
    [[AFHttpClient sharedAFHttpClient]sendResponseWithUserid:[AccountManager sharedAccountManager].loginModel.userid brid:model.brid operate:@"0" type:str complete:^(BaseModel *model) {
        if ([model.retCode isEqualToString:@"SUCCESS"]) {
            [self initRefreshView];
            [[AppUtil appTopViewController]showHint:@"SUCCESS"];
        }
        
    }];

}

-(void)acceptButtontouch:(UIButton *)sender{
    NSInteger i = sender.tag - 220;
    NewmessageModel * model = self.dataSource[i];
    NSString * str = model.type;
    
    [[AFHttpClient sharedAFHttpClient]sendResponseWithUserid:[AccountManager sharedAccountManager].loginModel.userid brid:model.brid operate:@"1" type:str complete:^(BaseModel *model) {
        if ([model.retCode isEqualToString:@"SUCCESS"]) {
            [self initRefreshView];
            [[AppUtil appTopViewController]showHint:@"SUCCESS"];
        }

    }];
    
    

}

















@end
