//
//  SelectalbumTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/4.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "SelectalbumTableViewCell.h"

@implementation SelectalbumTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstImage = [[UIImageView alloc]init];
        _firstImage.backgroundColor = [UIColor blackColor];
        [self addSubview:_firstImage];
        [_firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_firstImage.superview.mas_left).offset(17);
            //make.centerY.equalTo(_firstImage.superview.mas_centerY);
            make.top.equalTo(_firstImage.superview.mas_top).offset(12);
            make.width.height.mas_equalTo(43);
    
        }];
        
        _secoendImage = [[UIImageView alloc]init];
        _secoendImage.backgroundColor = [UIColor redColor];
        [self addSubview:_secoendImage];
        [_secoendImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_secoendImage.superview.mas_left).offset(16);
            make.top.equalTo(_secoendImage.superview.mas_top).offset(11);
            make.width.height.mas_equalTo(43);
            
        }];
        
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = FENLINE_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLabel.superview).offset(16);
            make.right.equalTo(_lineLabel.superview).offset(-16);
            make.top.equalTo(_lineLabel.superview);
            make.height.mas_equalTo(0.5);
        }];
        
        _nameLabel = [[UILabel alloc]init];
       // _nameLabel
        
        
        
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:[UIImage imageNamed:@"selectalbum.png"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"red_seleted.png"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightBtn.superview).offset(-16);
            make.centerY.equalTo(_rightBtn.superview.mas_centerY);
            make.width.height.mas_equalTo(17);
            
        }];
        
        
        
        
        
        
    }



    return self;
}
@end
