//
//  MydevicesTableViewCell.m
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "MydevicesTableViewCell.h"

@implementation MydevicesTableViewCell
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
        
        _leftlabel = [[UILabel alloc]init];
        _leftlabel.textColor = [UIColor blackColor];
        _leftlabel.font = [UIFont systemFontOfSize:17.5];
        [self addSubview:_leftlabel];
        [_leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftlabel.superview.mas_left).offset(16);
            make.centerY.equalTo(_leftlabel.superview.mas_centerY);
            
        }];
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:17.5];
        _rightLabel.textColor = [UIColor blackColor];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightLabel.superview.mas_right).offset(-16);
            make.centerY.equalTo(_rightLabel.superview.mas_centerY);;
            
        }];
        
        _rightImage = [[UIImageView alloc]init];
        [_rightImage setImage:[UIImage imageNamed:@"rightjiantou.png"]];
        [self addSubview:_rightImage];
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImage.superview.mas_right).offset(-16);
            make.centerY.equalTo(_rightImage.superview.mas_centerY);
            make.width.mas_equalTo(6);
            make.height.mas_equalTo(11);
            
        }];
        
        
        
        
        
        
        
        
    }


    return self;
}


@end
