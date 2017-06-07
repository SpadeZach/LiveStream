//
//  TabBarController.m
//  LiveStream
//
//  Created by 赵博 on 17/4/19.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "TabBarController.h"
#import "VideoListController.h"
#import "LiveController.h"
#import "MainViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupTabBarBackgroundImage];
}

/**
 *  初始化一个子控制器
 *
 *  @param vc         子控制器类名
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    //加载图片
    UIImage *normlTemp = [UIImage imageNamed:image];
    //产生一张不会被渲染的图片
    UIImage *normlImg= [normlTemp imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = normlImg;
    
    UIImage *tempImage = [UIImage imageNamed:selectedImage];
    UIImage *seleImage= [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = seleImage;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    [self addChildViewController:vc];
}
- (void)setupChildViewControllers{
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[VideoListController alloc] init]] title:nil image:@"tab_live" selectedImage:@"tab_live_p"];
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[LiveController alloc] init]] title:nil image:@"tab_room" selectedImage:@"tab_room_p"];
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]] title:nil image:@"tab_me" selectedImage:@"tab_me_p"];

}

- (void)setupTabBarBackgroundImage {
    
    //    //隐藏阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    UIImage *image = [UIImage imageNamed:@"tab_bg"];
    
    CGFloat top = 40; // 顶端盖高度
    CGFloat bottom = 40 ; // 底端盖高度
    CGFloat left = 100; // 左端盖宽度
    CGFloat right = 100; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
//     指定为拉伸模式，伸缩后重新赋值
    UIImage *TabBgImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    self.tabBar.backgroundImage = TabBgImage;
    
}
//自定义TabBar高度
- (void)viewWillLayoutSubviews {
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 60;
    tabFrame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = tabFrame;
    
}


@end
