//
//  videodetailViewController.h
//  ku耳
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018 WO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
NS_ASSUME_NONNULL_BEGIN

@interface videodetailViewController : UIViewController
@property(nonatomic,strong)NSString *MP4url;
@property(nonatomic,strong)NSString *MP4image;
@property(nonatomic,assign)int  I;
@end

NS_ASSUME_NONNULL_END
