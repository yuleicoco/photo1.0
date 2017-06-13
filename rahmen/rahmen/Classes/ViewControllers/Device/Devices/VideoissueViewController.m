//
//  VideoissueViewController.m
//  rahmen
//
//  Created by czx on 2017/6/12.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "VideoissueViewController.h"
#import "SCRecorder.h"
#import "SCRecordSessionManager.h"
#import "MydevicesViewController.h"
#import "AFHttpClient+Devices.h"

@interface VideoissueViewController ()<UITextViewDelegate>
@property (nonatomic,strong)SCPlayer *player;
@property (nonatomic,strong)UITextView * topTextView;
@property (nonatomic,strong)UILabel * placeholderLabel;
@end

@implementation VideoissueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGRAY_COLOR;
    [self showBarButton:NAV_RIGHT title:@"Confirm" fontColor:ZIYELLOW_COLOR hide:NO];
}
-(void)setupView{
    [super setupView];
    _topTextView = [[UITextView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 150 * W_Hight_Zoom)];
    _topTextView.textAlignment = NSTextAlignmentLeft;
    _topTextView.backgroundColor = [UIColor whiteColor];
    _topTextView.delegate = self;
    _topTextView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_topTextView];
    
    
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.text = @"请输入内容";
    _placeholderLabel.font = _topTextView.font;
    _placeholderLabel.layer.cornerRadius = 5;
    [self.view addSubview:_placeholderLabel];
    
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.tag = 500;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerView.frame = CGRectMake(0 * W_Wide_Zoom, 160* W_Hight_Zoom, 100 * W_Wide_Zoom, 100 * W_Hight_Zoom);
    [self.view addSubview:playerView];
    _player.loopEnabled = YES;
    [_player setItemByUrl:self.urlstr];
   // [_player play];

}

-(void)doLeftButtonTouch{
//    MydevicesViewController * vc = [[MydevicesViewController alloc]init];
//    vc.didstr = _didStr;
    //返回指定界面，需要先遍历一下自己的navigationController.viewControllers，然后取
    UIViewController *viewCtl = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:viewCtl animated:NO];


}

-(void)doRightButtonTouch{
     [self showHudInView:self.view hint:@"正在发布..."];
    [[AFHttpClient sharedAFHttpClient]sendVideoWithUserid:[AccountManager sharedAccountManager].loginModel.userid did:_didStr content:_topTextView.text video:_str complete:^(BaseModel *model) {
        if (model) {
            [[AppUtil appTopViewController]showHint:model.retDesc];
            UIViewController *viewCtl = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:viewCtl animated:NO];
        }
        
        [self hideHud];
    }];






}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    _placeholderLabel.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_topTextView.text.length == 0) {
        _placeholderLabel.text = @"  请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
    
    
}
@end
