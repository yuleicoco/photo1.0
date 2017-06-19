//
//  DeviceViewTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "DeviceViewTableViewCell.h"

@implementation DeviceViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = FENLINE_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLabel.superview).offset(16);
            make.right.equalTo(_lineLabel.superview).offset(-16);
            make.top.equalTo(_lineLabel.superview).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
        
        _leftImage = [[UIImageView alloc]init];
        [_leftImage setImage:[UIImage imageNamed:@"device1.png"]];
        [self addSubview:_leftImage];
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImage.superview.mas_left).offset(15);
            make.centerY.equalTo(_leftImage.superview.mas_centerY);
            make.width.height.mas_equalTo(17);
            
        }];
        
        _devicenameLabel = [[UILabel alloc]init];
        _devicenameLabel.textColor = [UIColor blackColor];
        _devicenameLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_devicenameLabel];
        [_devicenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_devicenameLabel.superview.mas_centerY);
            make.left.equalTo(_leftImage.mas_right).offset(17.5);
            
        }];
        
        _rightImage = [[UIImageView alloc]init];
        [_rightImage setImage:[UIImage imageNamed:@"rightjiantou.png"]];
        [self addSubview:_rightImage];
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImage.superview.mas_right).offset(-16);
            make.centerY.equalTo(_rightImage.superview.mas_centerY);
            make.width.mas_equalTo(6);
            make.height.mas_equalTo(11);
            
        }];
        
        _hongImage = [[UIImageView alloc]init];
        _hongImage.backgroundColor = [UIColor redColor];
        _hongImage.layer.cornerRadius = 3;
        [self addSubview:_hongImage];
        [_hongImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_hongImage.superview.mas_right).offset(-30);
            make.centerY.equalTo(_hongImage.superview.mas_centerY);
            make.width.height.mas_equalTo(6);
            
        }];
        
        
        
        
        
        
    }

    return self;
}

@end
