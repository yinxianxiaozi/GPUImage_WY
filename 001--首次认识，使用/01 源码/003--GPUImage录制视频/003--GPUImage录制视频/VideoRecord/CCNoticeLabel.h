//
//  CCNoticeLabel.h
//  003--GPUImage录制视频
//
//  Created by CC老师 on 2018/6/7.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCNoticeLabel : UIView
/**
 *  功能：提示框
 *  用法： [self.view addSubView:[LMNoticeLabel message:@"我是测试文字" delaySecond:2.0]];
 *  param
 *  message: 要显示的文字信息
 *  second:  显示文字的时间
 */
+(instancetype)message:(NSString *)message delaySecond:(CGFloat)second;
@end
