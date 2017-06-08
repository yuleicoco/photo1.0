//
//  DeviceViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "DeviceViewController.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Devices"];
    self.view.backgroundColor =BACKGRAY_COLOR;
}

-(void)setupView{
    [super setupView];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView.superview);
        make.height.mas_equalTo(10.5);
    }];
    
    UIView * receivedView = [[UIView alloc]init];
    receivedView.backgroundColor = [UIColor blackColor];
    [topView addSubview:receivedView];
    [receivedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView.superview);
        make.height.mas_equalTo(50);
    }];
    
//    UILabel * lineLabel = [[UILabel alloc]init];
//    lineLabel.backgroundColor = FENLINE_COLOR;
//    [topView addSubview:lineLabel];
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lineLabel.superview.mas_left).offset(16);
//        make.right.equalTo(lineLabel.superview.mas_right).offset(-16);
//        make.centerY.equalTo(lineLabel.superview.mas_centerY);
//        make.height.mas_equalTo(0.5);
//    }];
    
    
    
    
    
    
    
    

}
-(void)setupData{
    [super setupData];


}











@end
