//
//  MainViewController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/26.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "MainViewController.h"
#import "FaceToFaceController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)pushDetail:(UIButton *)sender {
    FaceToFaceController *faceVC = [[FaceToFaceController alloc] init];
    [self presentViewController:faceVC animated:faceVC completion:nil];
}

@end
