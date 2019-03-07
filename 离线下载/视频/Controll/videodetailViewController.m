//
//  videodetailViewController.m
//  ku耳
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018 WO. All rights reserved.
//
#import "First.h"
#import "videodetailViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface videodetailViewController ()
{
    AVPlayerViewController      *_playerController;
    AVPlayer                    *_player;
    AVAudioSession              *_session;
    NSString                    *_urlString;
    
}
@property (nonatomic,strong)UIButton *selbun;

@end

@implementation videodetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"音频列表_播放入口动画"] style:UIBarButtonItemStylePlain target:self action:@selector(downLoad)];

    
    
    _session = [AVAudioSession sharedInstance];
    [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    _player = [AVPlayer playerWithURL:[NSURL URLWithString:self.MP4url]];
    _playerController = [[AVPlayerViewController alloc] init];
    _playerController.player = _player;
    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    
    _playerController.showsPlaybackControls = true;
    [self addChildViewController:_playerController];
    _playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
    _playerController.view.frame = CGRectMake(0, 50, WIDTH, 400);
    [self.view addSubview:_playerController.view];
    [_playerController.player play];
    
    
    
}
-(void)downLoad{
//bys
    //AppDdelegate全局传值
    AppDelegate *app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    app.mp4Url  =  self.MP4url;
    app.mp4image  =  self.MP4image;
    
//    if([app.mp4Url respondsToSelector:@selector(downLoad)])
//    {
//
//
//    }else
//    {

        self.I=1; //掌管循环
        app.i=self.I;
    First *firstadd = [[First alloc]init];
    [firstadd addDownLoadData];
    //
    [YJProgressHUD showMessage:@"别点了，已经下载上了" inView:self.view afterDelayTime:3.0];
}


@end
