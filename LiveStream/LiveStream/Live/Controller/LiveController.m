//
//  LiveController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/21.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "LiveController.h"
#import "LiveDetailController.h"
@interface LiveController ()

@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)clickLive:(UIButton *)sender {
    LiveDetailController *live = [[LiveDetailController alloc] init];
    [self presentViewController:live animated:YES completion:nil];
}
@end
