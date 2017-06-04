//
//  HomeviewTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/3.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "HomeviewTableViewCell.h"

@implementation HomeviewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = BACKGRAY_COLOR;
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_topView.superview);
            make.top.equalTo(_topView.superview);
            make.height.mas_equalTo(8);
        }];
        
        _headImage = [[UIImageView alloc]init];
        _headImage.backgroundColor = [UIColor redColor];
        _headImage.layer.cornerRadius = 22.5;
        [self addSubview:_headImage];
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.superview.mas_left).offset(16);
            make.top.equalTo(_headImage.superview.mas_top).offset(13);
            make.width.height.mas_equalTo(45);
            
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.mas_right).offset(15);
            make.centerY.equalTo(_headImage.mas_centerY);
            
        }];
        
        _bigImage = [[UIImageView alloc]init];
        _bigImage.backgroundColor = [UIColor clearColor];
         _bigImage.layer.masksToBounds = YES;
        _bigImage.contentMode = UIViewContentModeCenter;
        [self addSubview:_bigImage];
        [_bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bigImage.superview);
            make.top.equalTo(_headImage.mas_bottom).offset(13);
            make.height.mas_equalTo(250);
            
        }];
        _bigBtn = [[UIButton alloc]init];
        _bigBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_bigBtn];
        [_bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(_bigImage);
            make.left.right.top.equalTo(_bigImage);
            
        }];
        
        
        
        
        _contView = [[UIView alloc]init];
        _contView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contView];
        [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_contView.superview);
            make.top.equalTo(_bigImage.mas_bottom);
            make.height.mas_equalTo(40);
            
        }];
        
        _conttentLabel = [[UILabel alloc]init];
        _conttentLabel.textColor = [UIColor blackColor];
        _conttentLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_conttentLabel];
        [_conttentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_conttentLabel.superview).offset(16);
            make.centerY.equalTo(_contView.mas_centerY);
            
        }];
        
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = BACKGRAY_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_lineLabel.superview);
            make.top.equalTo(_contView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bottomView.superview);
            make.top.equalTo(_lineLabel.mas_bottom);
            make.bottom.equalTo(_bottomView.superview.mas_bottom);
            
        }];
        
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = FENLINE_COLOR;
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dateLabel.superview).offset(16);
            make.centerY.equalTo(_bottomView.mas_centerY);

        }];
        
        _pinglunBtn = [[UIButton alloc]init];
        [_pinglunBtn setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
        [self addSubview:_pinglunBtn];
        [_pinglunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_pinglunBtn.superview.mas_right).offset(-17);
            make.centerY.equalTo(_bottomView.mas_centerY);
            make.width.height.mas_equalTo(21);
            
            
        }];
        
        
        
        
        
        _dianzanBtn = [[UIButton alloc]init];
        [_dianzanBtn setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        [_dianzanBtn setImage:[UIImage imageNamed:@"dianzanhou.png"] forState:UIControlStateSelected];
        [self addSubview:_dianzanBtn];
        [_dianzanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_pinglunBtn.mas_left).offset(-17);
            make.centerY.equalTo(_bottomView.mas_centerY);
            make.width.height.mas_equalTo(21);
            
            
        }];
        
        
        
    }


    return self;
}
@end
