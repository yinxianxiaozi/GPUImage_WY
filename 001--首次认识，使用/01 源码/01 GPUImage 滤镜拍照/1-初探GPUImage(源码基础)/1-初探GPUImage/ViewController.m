//
//  ViewController.m
//  1-初探GPUImage
//
//  Created by CC老师 on 2018/4/19.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import <PhotosUI/PhotosUI.h>
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface ViewController ()

@property(strong,nonatomic)GPUImageVideoCamera *vCamera;

@property(strong,nonatomic)GPUImageStillCamera *mCamera;
@property(strong,nonatomic) GPUImageFilter *mFilter;
@property(strong,nonatomic) GPUImageView *mGPUImgView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //添加GPUImage
    [self addFiterCamera];
    
    //添加一个按钮触发拍照
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-80)*0.5, self.view.bounds.size.height-120, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
  
}

-(void)addFiterCamera
{
    //1.
    //第一个参数表示相片的尺寸，第二个参数表示前、后摄像头 AVCaptureDevicePositionFront/AVCaptureDevicePositionBack
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    
    //2.切换摄像头
    [_mCamera rotateCamera];
    
    //3.竖屏方向
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //4.设置滤镜对象
    //这个滤镜你可以换其它的，官方给出了不少滤镜
    _mFilter = [[GPUImageGrayscaleFilter alloc] init];
    
    //5.
    _mGPUImgView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mGPUImgView];
    [self.view addSubview:_mGPUImgView];
    
    //6.
    [_mCamera startCameraCapture];
    
}

-(void)takePhoto{
   
    //7.将图片通过PhotoKit add 相册中
    [_mCamera capturePhotoAsJPEGProcessedUpToFilter:_mFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    
            [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:processedJPEG options:nil];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
        }];
        
        //获取拍摄的图片
        UIImage * image = [UIImage imageWithData:processedJPEG];
        
    }];
    

}


@end
