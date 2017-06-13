//
//  MyvideoTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MyvideoTableViewCell.h"

@implementation MyvideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = PLACEHOLDER_COLOR;
        _timeLabel.font = [UIFont systemFontOfSize:11];
       // _timeLabel.text = @"201323212132131";
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_timeLabel.superview.mas_centerX);
            make.top.equalTo(_timeLabel.superview.mas_top).offset(9);
    
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:12.5];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"Tone";
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.superview.mas_top).offset(30);
            make.right.equalTo(_nameLabel.superview.mas_right).offset(-77);
            
        }];
        
        _headImage = [[UIImageView alloc]init];
        _headImage.layer.cornerRadius = 22.5;
        [_headImage.layer setMasksToBounds:YES];
        _headImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_headImage];
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headImage.superview.mas_right).offset(-16);
            make.top.equalTo(_headImage.superview.mas_top).offset(26);
            make.width.height.mas_equalTo(45);

        }];
        
        _bigImage = [[UIImageView alloc]init];
        _bigImage.backgroundColor = [UIColor clearColor];
        [_bigImage.layer setMasksToBounds:YES];
        _bigImage.layer.cornerRadius = 4;
        [self addSubview:_bigImage];
        [_bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_bigImage.superview.mas_right).offset(-77);
            make.top.equalTo(_bigImage.superview.mas_top).offset(45);
            make.width.mas_equalTo(105);
            make.height.mas_equalTo(150);
            
        }];
        
        _contLabel = [[UILabel alloc]init];
        _contLabel.textColor = [UIColor blackColor];
        _contLabel.font = [UIFont systemFontOfSize:15];
        _contLabel.text = @"How is it going";
        [self addSubview:_contLabel];
        [_contLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bigImage.mas_left);
            make.top.equalTo(_bigImage.mas_bottom).offset(5.5);

        }];
        
        
        _centerImage = [[UIImageView alloc]init];
        [_centerImage setImage:[UIImage imageNamed:@"playbutton"]];
        [self addSubview:_centerImage];
        [_centerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bigImage.mas_centerX);
            make.centerY.equalTo(_bigImage.mas_centerY);
            make.width.height.mas_equalTo(25);
            
        }];
        
        
        
        
        
        
        
    }
    
    return self;
}

@end
