//
//  AboutTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/16.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell
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
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_nameLabel.superview.mas_centerY);
            make.centerX.equalTo(_nameLabel.superview.mas_centerX);
            
            
        }];
        
        
        
        
    }


    return self;
}

@end
