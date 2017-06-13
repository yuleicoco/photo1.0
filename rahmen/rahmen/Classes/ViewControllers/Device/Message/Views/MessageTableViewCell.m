//
//  MessageTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
        
        
        
        _headImage = [[UIImageView alloc]init];
        _headImage.layer.cornerRadius = 22.5;
        [_headImage.layer setMasksToBounds:YES];
        _headImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_headImage];
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.superview.mas_left).offset(16);
            make.centerY.equalTo(_headImage.superview.mas_centerY);
            make.height.width.mas_equalTo(45);
            
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.5];
       // _nameLabel.text = @"Sego";
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.mas_right).offset(14);
            make.top.equalTo(_nameLabel.superview.mas_top).offset(22);
            
        }];
        
        _inOrquestLabel = [[UILabel alloc]init];
        _inOrquestLabel.textColor = [UIColor blackColor];
        _inOrquestLabel.font = [UIFont systemFontOfSize:12.5];
       // _inOrquestLabel.text = @"invite";
        [self addSubview:_inOrquestLabel];
        [_inOrquestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.mas_right).offset(14);
            make.top.equalTo(_nameLabel.mas_bottom).offset(9);
            
        }];
        
        _deveicemarkeLabel = [[UILabel alloc]init];
        _deveicemarkeLabel.textColor = [UIColor blackColor];
        _deveicemarkeLabel.font = [UIFont systemFontOfSize:12.5];
      //  _deveicemarkeLabel.text = @"730000045678";
        [self addSubview:_deveicemarkeLabel];
        [_deveicemarkeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inOrquestLabel.mas_right).offset(5);
            make.top.equalTo(_inOrquestLabel.mas_top);
            
        }];
        
        _AcceptBtn = [[UIButton alloc]init];
        _AcceptBtn.backgroundColor = ZIYELLOW_COLOR;
        _AcceptBtn.layer.cornerRadius = 4;
        [_AcceptBtn setTitle:@"Accept" forState:UIControlStateNormal];
        [_AcceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _AcceptBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
        [self addSubview:_AcceptBtn];
        [_AcceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_AcceptBtn.superview.mas_right).offset(-16);
            make.centerY.equalTo(_AcceptBtn.superview);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(25);
            
        }];
        
        _rejectBtn = [[UIButton alloc]init];
        _rejectBtn.backgroundColor = [UIColor whiteColor];
        [_rejectBtn setTitle:@"Reject" forState:UIControlStateNormal];
        [_rejectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rejectBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
        _rejectBtn.layer.borderWidth = 0.5;
        _rejectBtn.layer.borderColor = FENLINE_COLOR.CGColor;
        _rejectBtn.layer.cornerRadius = 4;
        [self addSubview:_rejectBtn];
        [_rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_AcceptBtn.mas_left).offset(-10);
            make.centerY.equalTo(_rejectBtn.superview);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(25);
        }];
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor =PLACEHOLDER_COLOR;
        _rightLabel.font = [UIFont systemFontOfSize:12.5];
      //  _rightLabel.text = @"Accepted";
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightLabel.superview).offset(-16);
            make.centerY.equalTo(_rightLabel.superview.mas_centerY);
            
            
            
        }];
        
        
        
        
        
        
        
        
        
        
        
        
        
    }



    return self;
}


@end
