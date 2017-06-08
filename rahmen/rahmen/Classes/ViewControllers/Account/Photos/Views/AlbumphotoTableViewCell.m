//
//  AlbumphotoTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AlbumphotoTableViewCell.h"

@implementation AlbumphotoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = FENLINE_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLabel.superview.mas_left).offset(16);
            make.right.equalTo(_lineLabel.superview.mas_right).offset(-16);
            make.top.equalTo(_lineLabel.superview);
            make.height.mas_equalTo(0.5);
        }];
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftLabel.superview.mas_left).offset(17.5);
            make.centerY.equalTo(_leftLabel.superview);
        }];
        
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:[UIImage imageNamed:@"selectalbum.png"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"red_seleted.png"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightBtn.superview.mas_right).offset(-16);
            make.centerY.equalTo(_rightBtn.superview);
            make.width.height.mas_equalTo(17);
            
        }];
        
        
        
        
        
    }

    return self;
}
@end
