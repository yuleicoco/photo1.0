//
//  RegiestTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/2.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "RegiestTableViewCell.h"

@implementation RegiestTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = FENLINE_COLOR;
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLabel.superview);
            make.right.equalTo(_lineLabel.superview);
            make.top.equalTo(_lineLabel.superview);
            make.height.mas_equalTo(0.5);
        }];
        
        
        _leftImage = [[UIImageView alloc]init];
        _leftImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_leftImage];
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImage.superview.mas_left).offset(17);
            make.centerY.equalTo(_leftImage.superview);
            //make.width.height.mas_equalTo(16);
            
            
        }];

        
        
    }

    return self;
}

@end
