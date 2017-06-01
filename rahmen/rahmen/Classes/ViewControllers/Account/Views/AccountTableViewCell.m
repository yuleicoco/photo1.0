//
//  AccountTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/1.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = FENLINE_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLabel.superview).offset(12);
            make.right.equalTo(_lineLabel.superview).offset(-12);
            make.top.equalTo(_lineLabel.superview).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        _leftImage = [[UIImageView alloc]init];
        _leftImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_leftImage];
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImage.superview.mas_left).offset(17);
            make.centerY.equalTo(_leftImage.superview);
            make.width.height.mas_equalTo(16);
            
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.5];
        _nameLabel.text = @"哈哈";
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImage.mas_right).offset(16);
            make.centerY.equalTo(_nameLabel.superview.mas_centerY);
        }];
        
        
        
        
        
        
    }
    


    return self;
}



@end
