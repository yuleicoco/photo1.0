//
//  MyvideoViewController.m
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MyvideoViewController.h"
#import "MyvideoTableViewCell.h"
#import "AFHttpClient+Devices.h"
#import "MyvideoModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImage-Extensions.h"
#import <AVFoundation/AVFoundation.h>

static NSString * cellId = @"MyvideoTableViewCellId";
@interface MyvideoViewController ()

@end

@implementation MyvideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)setupView{
    [super setupView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView.superview);
//        make.left.right.equalTo(self.tableView.superview);
//        //make.height.mas_equalTo(self.view.height);
//    }];
     self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height-20);
    [self.tableView registerClass:[MyvideoTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]queryVideosByDidWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didStr page:[NSString stringWithFormat:@"%d",page] complete:^(BaseModel *model) {
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
    return 224;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyvideoModel *model = self.dataSource[indexPath.row];
    MyvideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    //根据数据更新约束
    if (![model.sender isEqualToString:[AccountManager sharedAccountManager].loginModel.userid]) {
        [cell.headImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.headImage .superview.mas_left).offset(16);
            make.top.equalTo(cell.headImage .superview.mas_top).offset(26);
            make.width.height.mas_equalTo(45);
        }];
        
        [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.nameLabel.superview.mas_top).offset(30);
            make.left.equalTo(cell.nameLabel.superview.mas_left).offset(77);
        }];
        
        [cell.bigImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.bigImage.superview.mas_left).offset(77);
            make.top.equalTo(cell.bigImage.superview.mas_top).offset(50);
            make.width.mas_equalTo(105);
            make.height.mas_equalTo(150);
            
        }];
        
    }else{
        [cell.headImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.headImage .superview.mas_right).offset(-16);
            make.top.equalTo(cell.headImage .superview.mas_top).offset(26);
            make.width.height.mas_equalTo(45);
        }];
        
        [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.nameLabel.superview.mas_top).offset(30);
            make.right.equalTo(cell.nameLabel.superview.mas_right).offset(-77);
        }];
        
        [cell.bigImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.bigImage.superview.mas_right).offset(-77);
            make.top.equalTo(cell.bigImage.superview.mas_top).offset(50);
            make.width.mas_equalTo(105);
            make.height.mas_equalTo(150);
            
        }];
    
    }
    
    NSString * headStr = model.headportrait;
    NSURL * headUrl = [NSURL URLWithString:headStr];
    [cell.headImage sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"morentouxiang.png"]];
    
    NSString * bigstr = model.thumbnails;
    NSURL * bigUrl = [NSURL URLWithString:bigstr];
    [cell.bigImage sd_setImageWithURL:bigUrl placeholderImage:[UIImage imageNamed:@"albummorenren.png"]];
    
    cell.timeLabel.text = model.opttime;
    cell.nameLabel.text = model.name;
    cell.contLabel.text = model.content;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyvideoModel *model = self.dataSource[indexPath.row];
    MPMoviePlayerViewController * vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    
    
    [self presentMoviePlayerViewControllerAnimated:vc];

    
    


}




@end
