//
//  HomeViewController.m
//  rahmen
//
//  Created by czx on 2017/5/31.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 136, 20)];
    titleImage.image = [UIImage imageNamed:@"whitezi.png"];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self setTitleView:titleImage];

    
    
    
}



@end
