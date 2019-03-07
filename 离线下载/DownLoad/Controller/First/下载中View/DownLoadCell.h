//
//  DownLoadCell.h
//  离线下载
//
//  Created by mac on 2019/2/22.
//  Copyright © 2019 WO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define DownLoadCell_Height         80.0  //cell行高
@interface DownLoadCell : UITableViewCell
@property (strong, nonatomic) QSPDownloadSource *source;

@end

NS_ASSUME_NONNULL_END
