//
//  MessageTableViewCell.h
//  rahmen
//
//  Created by czx on 2017/6/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * inOrquestLabel;
@property (nonatomic,strong)UILabel * deveicemarkeLabel;
@property (nonatomic,strong)UILabel * rightLabel;
@property (nonatomic,strong)UIButton * rejectBtn;
@property (nonatomic,strong)UIButton * AcceptBtn;
@property (nonatomic,strong)UILabel * lineLabel;


@end
