//
//  FaceToFaceController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/26.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "FaceToFaceController.h"
#import "VideoModel.h"
#import "StartLiveView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface FaceToFaceController ()
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 直播开始前的占位图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;
@end

@implementation FaceToFaceController

- (UIImageView *)placeHolderView
{
    if (!_placeHolderView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.view.bounds;
        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
        [self.view addSubview:imageView];
        _placeHolderView = imageView;
        
        //        [self showGifLoding:nil inView:self.placeHolderView];
        // 强制布局
        [_placeHolderView layoutIfNeeded];
    }
    return _placeHolderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建播放器
    [self creatVideoPlayer];
    [self creatToolView];
    
}
- (void)creatToolView{
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    toolView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:toolView aboveSubview:self.moviePlayer.view];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"close_preview"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:backBtn];
    
    
    UIView *liveView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 170, 20, 150, 200)];
    liveView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:liveView atIndex:1];
    
    StartLiveView *view = [[StartLiveView alloc] initWithFrame:liveView.bounds];
    [liveView addSubview:view];
//    [self.view insertSubview:liveView aboveSubview:self.moviePlayer.view];


    
    
}
- (void)back{
    
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [self.moviePlayer pause];
        [self.moviePlayer stop];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)creatVideoPlayer{
    if (self.moviePlayer) {
        [self.moviePlayer shutdown];
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
//    //此方法会先从memory中取。
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.model.bigpic ]options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //            [self.parentVc showGifLoding:nil inView:self.placeHolderView];
//            self.placeHolderView.image = [UIImage blurImage:image blur:0.8];
//        });
//    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"http://hdl.9158.com/live/539e64fa447b1a38ae46a2920bbdbdac.flv" withOptions:options];
    moviePlayer.view.frame = self.view.bounds;
    
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    
    [self.view addSubview:moviePlayer.view];
    
    [moviePlayer prepareToPlay];
    
    self.moviePlayer = moviePlayer;
    // 设置监听
    [self initObserver];
    
}

- (void)initObserver{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

#pragma mark - notify method

- (void)stateDidChange{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                    //                    [self.moviePlayer.view addSubview:_renderer.view];
                }
                //                [self hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            //            if (self.gifView.isAnimating) {
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ////                    [self hideGufLoding];
            //                });
            
            //            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        //        [self showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    //    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
    //        [self showGifLoding:nil inView:self.moviePlayer.view];
    //        return;
    //    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
    [AKNewWorking getDataWithURL:@"http://hdl.9158.com/live/539e64fa447b1a38ae46a2920bbdbdac.flv" dic:nil success:^(id responseObject) {
        [weakSelf.moviePlayer play];
        
        
    } filed:^(NSError *error) {
        [weakSelf.moviePlayer shutdown];
        [weakSelf.moviePlayer.view removeFromSuperview];
        weakSelf.moviePlayer = nil;
        
        //        [MBProgressHUD showError:@"网络错误"];
    }];
    
    
}

@end
