//
//  AccountViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"

static NSString * cellId = @"accounttablvewCellid";
@interface AccountViewController ()
//下面的两组数据
@property (nonatomic,strong)NSArray * imageArry;
@property (nonatomic,strong)NSArray * nameArray;
//上面界面
@property (nonatomic,strong)UIImageView * headImage;




@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Account"];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView.superview);
        make.height.mas_equalTo(206 * W_Hight_Zoom);
        
    }];
    
    _headImage = [[UIImageView alloc]init];
    _headImage.backgroundColor = [UIColor clearColor];
    _headImage.layer.cornerRadius = 55;
      [_headImage.layer setMasksToBounds:YES];
     [_headImage sd_setImageWithURL:[NSURL URLWithString:[AccountManager sharedAccountManager].loginModel.headportrait] placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    [topView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImage.superview);
        make.top.equalTo(_headImage.superview.mas_top).with.offset(27);
        make.width.height.mas_equalTo(110);
        
    }];
    
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:17.5];
    nameLabel.text = [AccountManager sharedAccountManager].loginModel.nickname;
    
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nameLabel.superview);
        make.top.equalTo(_headImage.mas_bottom).offset(18);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(4);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(252.5);
        
    }];
    [self.tableView registerClass:[AccountTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;
    
    
    
    
}

-(void)setupData{
    [super setupData];
    _imageArry = @[@"phone.png",@"name.png",@"Albums.png",@"password.png",@"about.png"];
    _nameArray = @[@"dada",@"1232",@"czcz",@"44",@"adad"];
    
    
}


#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.leftImage.image = [UIImage imageNamed:_imageArry[indexPath.row]];
    cell.nameLabel.text = _nameArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.lineLabel.hidden = YES;
    }
    
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
