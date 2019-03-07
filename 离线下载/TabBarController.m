//
//  TabBarController.m
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    VdViewController *one = [[VdViewController alloc]init];
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:one];
    oneNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"1" image:[UIImage imageNamed:@"video_n"] selectedImage:[UIImage imageNamed:@"frequency_n"]];
    
    DownLoadViewController *two= [[DownLoadViewController alloc]init];
    UINavigationController *twoNav = [[UINavigationController alloc]initWithRootViewController:two];
    twoNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"2" image:[UIImage imageNamed:@"video_h"] selectedImage:[UIImage imageNamed:@"frequency_h"]];
    

    self.viewControllers=@[oneNav,twoNav];

    self.tabBar.tintColor=[UIColor redColor];
    oneNav.tabBarItem.badgeValue=@"99";

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
