//
//  AboutViewController.m
//  rahmen
//
//  Created by czx on 2017/6/2.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTableViewCell.h"
static NSString * cellId = @"AboutTableViewCellIdd";
@interface AboutViewController ()
@property (nonatomic,strong)NSArray * nameArray;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGRAY_COLOR;
}
-(void)setupView{
    [super setupView];
    [self setNavTitle:@"About"];
    UIButton * exitBtn = [[UIButton alloc]init];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn setTitle:NSLocalizedString(@"about_exit", nil) forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
    exitBtn.layer.cornerRadius = 4;
    [exitBtn addTarget:self action:@selector(exitBtntouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(exitBtn.superview.mas_bottom).offset(-140 * W_Hight_Zoom);
        make.width.mas_equalTo(310 * W_Wide_Zoom);
        make.height.mas_equalTo(45 * W_Hight_Zoom);
        make.centerX.equalTo(exitBtn.superview.mas_centerX);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview.mas_top).offset(193 * W_Hight_Zoom);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.height.mas_equalTo(151 * W_Hight_Zoom);
        
    }];
    [self.tableView registerClass:[AboutTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.scrollEnabled = NO;


    UIImageView * topImage = [[UIImageView alloc]init];
    topImage.image = [UIImage imageNamed:@"huangzi.png"];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.superview.mas_top).offset(76 * W_Hight_Zoom);
        make.width.mas_equalTo(217 * W_Wide_Zoom);
        make.height.mas_equalTo(31 * W_Hight_Zoom);
        make.centerX.equalTo(topImage.superview.mas_centerX);
    }];

    UILabel * banbenLabel = [[UILabel alloc]init];
    banbenLabel.text = @"V 1.0";
    banbenLabel.font = [UIFont systemFontOfSize:15];
    banbenLabel.textColor = [UIColor blackColor];
    [self.view addSubview:banbenLabel];
    [banbenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    

}
-(void)setupData{
    [super setupData];
    _nameArray = @[@"Introduction",@"Feedback",@"License"];

}


#pragma mark -- 退出
-(void)exitBtntouch{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil) message:NSLocalizedString(@"me_tips", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel_bind", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure_bind", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
        [[AccountManager sharedAccountManager]logout];
        
        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
       // NSString * incodeNumStr = [userDefatluts objectForKey:@"incodeNum"];
        
        for(NSString* key in [dictionary allKeys]){
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }
        [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
       // [userDefatluts setObject:incodeNumStr forKey:@"incodeNum"];
    }]];

    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 * W_Hight_Zoom;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    cell.nameLabel.text = _nameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}









@end
