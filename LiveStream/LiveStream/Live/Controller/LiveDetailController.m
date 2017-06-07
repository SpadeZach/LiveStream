//
//  LiveDetailController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/21.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "LiveDetailController.h"
#import "StartLiveView.h"
@interface LiveDetailController ()

@end

@implementation LiveDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    StartLiveView *view = [[StartLiveView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

@end
