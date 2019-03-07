//
//  AppDelegate.h
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@property(nonatomic,strong)NSString *mp4Url;//app全局传值
@property(nonatomic,strong)NSString *mp4image;//app全局传值
@property(nonatomic,assign)int i;//app全局传值
@end

