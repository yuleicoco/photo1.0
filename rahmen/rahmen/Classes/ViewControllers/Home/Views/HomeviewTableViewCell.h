//
//  HomeviewTableViewCell.h
//  rahmen
//
//  Created by czx on 2017/6/3.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeviewTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIImageView * bigImage;
@property (nonatomic,strong)UILabel * conttentLabel;
@property (nonatomic,strong)UILabel * lineLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UIButton * dianzanBtn;
@property (nonatomic,strong)UIButton * pinglunBtn;

@property (nonatomic,strong)UIView * contView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UIButton * bigBtn;



@end
