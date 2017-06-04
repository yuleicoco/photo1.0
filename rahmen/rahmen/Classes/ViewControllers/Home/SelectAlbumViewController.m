//
//  SelectAlbumViewController.m
//  rahmen
//
//  Created by czx on 2017/6/4.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "SelectAlbumViewController.h"
#import "SelectalbumTableViewCell.h"

static NSString * cellId = @"selectalbumtabviewCellid";
@interface SelectAlbumViewController ()

@end

@implementation SelectAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Select the album"];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height-100);
    [self.tableView registerClass:[SelectalbumTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = BACKGRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  FamilyquanModel * model = self.dataSource[indexPath.row];
    SelectalbumTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }
    
    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
