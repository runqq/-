//
//  Model.h
//  ku耳
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018 WO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
//主标题
@property(nonatomic,copy)NSString *fileDescribe;
//主图片
@property(nonatomic,copy)NSString *imageUrl;
//视频
@property(nonatomic,copy)NSString *fileUrl;
@end

NS_ASSUME_NONNULL_END
