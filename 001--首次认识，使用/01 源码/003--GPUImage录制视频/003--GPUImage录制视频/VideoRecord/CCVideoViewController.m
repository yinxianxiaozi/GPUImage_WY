//
//  CCVideoViewController.m
//  003--GPUImage录制视频
//
//  Created by CC老师 on 2018/6/7.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "CCVideoViewController.h"
#define LMWID [UIScreen mainScreen].bounds.size.width
#define LMHEI [UIScreen mainScreen].bounds.size.height
#import <AVKit/AVKit.h>
#import "CCNoticeLabel.h"
#import "CCVideoManager.h"


@interface CCVideoViewController ()<CCVideoManagerProtocol>
{
     NSString *_filePath;
    
}
/** 视频播放视图 */
@property (nonatomic,strong) UIView *videoView;

@property (nonatomic,strong) AVPlayerViewController *player;

/** manager */
@property (nonatomic,strong) CCVideoManager *manager;

@end

@implementation CCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.UI
    [self setupUI];
    //2.CCVideoMananger
    [self setupVideoMananger];
}

#pragma mark --setUp
-(void)setupVideoMananger
{
    _manager = [[CCVideoManager alloc] init];
    _manager.delegate = self;
    [_manager showWithFrame:CGRectMake(20, 120, LMWID-40, LMHEI/2-1) superView:self.view];
    _manager.maxTime = 30.0;
}

-(void)setupUI {
    
    self.title = @"视频";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, LMWID/2, 44);
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"录制视频" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    stop.backgroundColor = [UIColor redColor];
    [stop setTitle:@"停止录制" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    stop.frame = CGRectMake(LMWID/2, 64, LMWID/2, 44);
    [stop addTarget:self action:@selector(endRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    
    self.videoView = [[UIView alloc] initWithFrame:CGRectMake(10, LMHEI/2, LMWID-20, LMHEI/2)];
    self.videoView.userInteractionEnabled = YES;
    
    UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
    play.frame = CGRectMake(0, LMHEI-60, LMWID, 50);
    [play setTitle:@"播放" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];

}

-(void)recordBtnAction:(UIButton *)btn {
    
    [_manager startRecording];
    
}

-(void)endRecording {
    
    [_manager endRecording];
}

-(void)playVideo {
    
    _player = [[AVPlayerViewController alloc] init];
    _player.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:_filePath]];
    _player.videoGravity = AVLayerVideoGravityResizeAspect;
    [self presentViewController:_player animated:NO completion:nil];
    
}

-(void)didStartRecordVideo {
    
    [self.view addSubview:[CCNoticeLabel message:@"开始录制..." delaySecond:2]];
}

-(void)didCompressingVideo {
    
    [self.view addSubview:[CCNoticeLabel message:@"视频压缩中..." delaySecond:2]];
    
}

-(void)didEndRecordVideoWithTime:(CGFloat)totalTime outputFile:(NSString *)filePath {
    
    [self.view addSubview:[CCNoticeLabel message:@" 录制完毕，时长:%lu  路径：%@" delaySecond:4]];
    _filePath = filePath;
    
}

- (void)dealloc
{
    NSLog(@"控制器销毁了");
}

@end
