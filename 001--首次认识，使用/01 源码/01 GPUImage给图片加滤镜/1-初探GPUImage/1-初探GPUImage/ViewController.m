//
//  ViewController.m
//  1-初探GPUImage
//
//  Created by CC老师 on 2018/4/19.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *kunImagView;
@property(nonatomic,strong)UIImage *kunImage;

//饱和度滤镜
@property(nonatomic,strong)GPUImageSaturationFilter *disFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.获取图片
    _kunImage = [UIImage imageNamed:@"kunkun1.jpeg"];
    
}

- (IBAction)SaturationChange:(UISlider *)sender {
    
    //2.选择合适的滤镜
    //饱和度：应用于图像的饱和度或去饱和度（0.0 - 2.0，默认为1.0）
    if (_disFilter == nil) {
        _disFilter = [[GPUImageSaturationFilter alloc]init];
    }
    //设置饱和度值
    _disFilter.saturation = 1.0;
    //设置要渲染的区域 --图片大小
    [_disFilter forceProcessingAtSize:_kunImage.size];
    //使用单个滤镜
    [_disFilter useNextFrameForImageCapture];
    //调整饱和度
    _disFilter.saturation = sender.value;
    
    //3.创建图片组件--数据源头(静态图片)
    GPUImagePicture *stillImageSoucer = [[GPUImagePicture alloc]initWithImage:_kunImage];
    //为图片添加一个滤镜
    [stillImageSoucer addTarget:_disFilter];
    //处理图片
    [stillImageSoucer processImage];
    
    //4.处理完成,从FrameBuffer帧缓存区中获取图片
    UIImage *newImage = [_disFilter imageFromCurrentFramebuffer];
    
    //更新图片
    _kunImagView.image = newImage;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
