//
//  DownLoadViewController.m
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import "DownLoadViewController.h"
#import "First.h"
#import "Second.h"
@interface DownLoadViewController ()

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   First  *guandian = [[First alloc]init];
    guandian.title=@"下载中";
    Second  *fabiao = [[Second alloc]init];
    fabiao.title=@"完成";
    
    SCNavTabBarController *scNav=[[SCNavTabBarController alloc]init];
    
    scNav.subViewControllers=@[guandian,fabiao];
    [scNav addParentController:self];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
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
