//
//  VideoListController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/19.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "VideoListController.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "ViewDetailController.h"
@interface VideoListController ()<UITableViewDelegate,UITableViewDataSource>
/** 接受model数组 */
@property(nonatomic, strong)NSMutableArray *videoArr;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation VideoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUrl];
    [self creatTable];
    
}
#pragma mark - table
- (void)creatTable{
    //禁止自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //屏幕height - navH -tabH
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 124) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_WIDTH  *  3 / 4 + 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoCell class]) bundle:nil] forCellReuseIdentifier:@"videoCell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //电视剧
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    cell.receiveModel = self.videoArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewDetailController *viewDtail = [[ViewDetailController alloc] init];
    
    viewDtail.model = self.videoArr[indexPath.row];
    [self presentViewController:viewDtail animated:YES completion:nil];
}
#pragma mark - url
- (void)getUrl{
    [AKNewWorking getDataWithURL:@"http://live.9158.com/Fans/GetHotLive?page=1"  dic:nil success:^(id responseObject) {
        self.videoArr = @[].mutableCopy;
        NSArray *tempArr = responseObject[@"data"][@"list"];
        for (NSDictionary *dic in tempArr) {
            VideoModel *model = [[VideoModel alloc] initWidthDictionary:dic];
            [self.videoArr addObject:model];
        }
        [self.tableView reloadData];
        
    } filed:^(NSError *error) {
        CustomLog(@"%@",error);
    }];
}
@end
