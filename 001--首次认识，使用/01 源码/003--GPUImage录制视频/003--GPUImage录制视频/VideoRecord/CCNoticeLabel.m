//
//  CCNoticeLabel.m
//  003--GPUImage录制视频
//
//  Created by CC老师 on 2018/6/7.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "CCNoticeLabel.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@implementation CCNoticeLabel

+(instancetype)message:(NSString *)message delaySecond:(CGFloat)second{
    
    CCNoticeLabel *_labelView = nil;
    if (_labelView == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        label.backgroundColor = [UIColor clearColor];
        label.text = message;
        // 文字颜色，字体，对其方式等，修改可在下列属性中修改
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        CGFloat wid = [label.text boundingRectWithSize:CGSizeMake(kScreenWidth/4*3-20, 33) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width;
        CGFloat hei = [label.text boundingRectWithSize:CGSizeMake(wid, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.height;
        [label setFrame:CGRectMake(10, 10, wid, hei)];
        
        _labelView = [[CCNoticeLabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-wid/2, kScreenHeight/2-hei/2+10, wid+20, hei+20)];
        [_labelView addSubview:label];
        _labelView.backgroundColor = [UIColor blackColor];
        _labelView.alpha = 0.7;
        _labelView.layer.cornerRadius = 8;
        _labelView.clipsToBounds = YES;
        
    }
    [_labelView removeFromItsSuperView:_labelView second:second];
    return _labelView;
}

-(void)removeFromItsSuperView:(CCNoticeLabel *)labelView second:(CGFloat)second{
    
    __weak typeof(labelView) weakSelf = labelView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeFromSuperview];
    });
    
}


@end
