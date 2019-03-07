//
//  VOCollectionViewCell.m
//  ku耳
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018 WO. All rights reserved.
//

#import "VOCollectionViewCell.h"
#import "VdViewController.h"
@implementation VOCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imagev];
        [self addSubview:self.labelI];
    }
    return self;
}

-(UIImageView *)imagev
{
    if (!_imagev) {
        _imagev= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2, 150)];
        
        _imagev.layer.masksToBounds = YES;
        _imagev.layer.cornerRadius = 50;
    }
    return _imagev;
}
-(UILabel *)labelI
{
    // 判断 如果没有内容 就创建
    if (!_labelI) {
        
        // 设置 frame
        _labelI = [[UILabel alloc] initWithFrame:CGRectMake(-25, 160, 280, 30)];
        
        // 设置 字体
        _labelI.font = [UIFont systemFontOfSize:15];
        _labelI.textColor = [UIColor grayColor];
        //居中
        _labelI.textAlignment = NSTextAlignmentCenter;
    }
    return _labelI;
}
@end
