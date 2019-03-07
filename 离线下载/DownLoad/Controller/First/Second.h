//
//  Second.h
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define QSPDownloadTool_DownloadFinishedSources_Path        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"QSPDownloadTool_DownloadFinishedSources.data"]
@interface Second : UIViewController

@end

NS_ASSUME_NONNULL_END
