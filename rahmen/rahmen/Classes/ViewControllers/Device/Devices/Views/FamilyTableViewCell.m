//
//  FamilyTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/11.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "FamilyTableViewCell.h"

@implementation FamilyTableViewCell
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
        _headImage.layer.cornerRadius = 17.5;
        [_headImage.layer setMasksToBounds:YES];
        _headImage.backgroundColor = [UIColor redColor];
        [self addSubview:_headImage];
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.superview.mas_left).offset(16);
            make.centerY.equalTo(_headImage.superview.mas_centerY);
            make.width.height.mas_equalTo(35);
            
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImage.mas_right).offset(14);
            make.centerY.equalTo(_nameLabel.superview.mas_centerY);
            
        }];
        
        _rightImage = [[UIImageView alloc]init];
        [_rightImage setImage:[UIImage imageNamed:@"guanliyuan.png"]];
        [self addSubview:_rightImage];
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImage.superview.mas_right).offset(-16);
            make.centerY.equalTo(_rightImage.superview.mas_centerY);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(18);
        }];
        
        
        
    }

    return self;
}







@end
