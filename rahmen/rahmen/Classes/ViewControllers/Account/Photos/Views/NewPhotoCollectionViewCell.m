//
//  NewPhotoCollectionViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/6.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "NewPhotoCollectionViewCell.h"

@implementation NewPhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        _backImage = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_backImage];
        
        _mengcengView = [[UIImageView alloc]initWithFrame:self.bounds];
        [_mengcengView setImage:[UIImage imageNamed:@"mengcheng.png"]];
        [self addSubview:_mengcengView];
        
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:[UIImage imageNamed:@"red_normal.png"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"red_seleted.png"] forState:UIControlStateSelected];
        _rightBtn.userInteractionEnabled = NO;
        _rightBtn.selected = NO;
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightBtn.superview.mas_right).offset(-10);
            make.top.equalTo(_rightBtn.superview.mas_top).offset(10);
            make.width.height.mas_equalTo(17);
            
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.superview.mas_left).offset(5);
            make.bottom.equalTo(_nameLabel.superview.mas_bottom).offset(-5);

        }];
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_numberLabel.superview.mas_right).offset(-5);
            make.bottom.equalTo(_numberLabel.superview.mas_bottom).offset(-5);
            
            
        }];
        
        
        
        
        
        
    }

    return self;
}


@end
