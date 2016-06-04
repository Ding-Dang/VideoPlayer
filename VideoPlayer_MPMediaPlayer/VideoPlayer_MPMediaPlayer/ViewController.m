//
//  ViewController.m
//  VideoPlayer_MPMediaPlayer
//
//  Created by 程利 on 16/6/4.
//  Copyright © 2016年 dingdang. All rights reserved.
//

//#define USE_MPMOVIEPLAYER

#import "ViewController.h"
#ifdef USE_MPMOVIEPLAYER
#import <MediaPlayer/MediaPlayer.h>
#else
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#endif

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setupSubviews];
}

- (void)setupSubviews {
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
}

- (void)playButtonClicked:(UIButton *)sender {
//    [self playLocalFile];
    [self playStream];
}

- (void)playLocalFile {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mov"];
#ifdef USE_MPMOVIEPLAYER
    MPMoviePlayerViewController *playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:videoPath]];
    playerController.moviePlayer.fullscreen = YES;
    playerController.moviePlayer.shouldAutoplay = YES;
    playerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [self presentViewController:playerController animated:YES completion:nil];
#else
    AVPlayerViewController *playerController = [[AVPlayerViewController alloc] init];
    playerController.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:videoPath]];
    [self presentViewController:playerController animated:YES completion:nil];
#endif
}

- (void)playStream {
    NSString *streamStr = @"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8";
#ifdef USE_MPMOVIEPLAYER
    MPMoviePlayerViewController *playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:streamStr]];
    playerController.moviePlayer.fullscreen = YES;
    playerController.moviePlayer.shouldAutoplay = YES;
    playerController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    [self presentViewController:playerController animated:YES completion:nil];
#else
    AVPlayerViewController *playController = [[AVPlayerViewController alloc] init];
    playController.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:streamStr]];
    [self presentViewController:playController animated:YES completion:nil];
#endif
}


@end
