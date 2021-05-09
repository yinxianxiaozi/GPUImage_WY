//
//  CCFilterMaterialViewCell.m
//  CCBeautifulCamera
//
//  Created by CC老师 on 2019/6/18.
//  Copyright © 2019年 CC老师. All rights reserved.
//

#import "CCGPUImageBaseFilter.h"

#import "CCFilterHelper.h"
#import "CCFilterManager.h"

#import "CCFilterMaterialViewCell.h"

@interface CCFilterMaterialViewCell ()

@property (nonatomic, strong) GPUImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) GPUImagePicture *picture;

@property (nonatomic, strong) UIView *selectView;

@end

@implementation CCFilterMaterialViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.picture removeAllTargets];
    self.selectView.hidden = YES;
}

#pragma mark - Private

- (void)commonInit {
    [self setupImageView];
    [self setupTitleLabel];
    [self setupSelectView];
    
     self.picture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"samperTeture.jpg"]];
}

- (void)setupImageView {
    self.imageView = [[GPUImageView alloc] init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 80));
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self);
    }];
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (void)setupSelectView {
    self.selectView = [[UIView alloc] init];
    self.selectView.hidden = YES;
    self.selectView.backgroundColor = ThemeColorA(0.8);
    [self addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageView);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_select"]];
    [self.selectView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.selectView);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
}

#pragma mark - Custom Accessor

- (void)setFilterMaterialModel:(CCFilterMaterialModel *)filterMaterialModel {
    _filterMaterialModel = filterMaterialModel;

    self.titleLabel.text = filterMaterialModel.filterName;
    
    GPUImageFilter *filter = [[CCFilterManager shareManager] filterWithFilterID:filterMaterialModel.filterID];
    
    if ([filter isKindOfClass:[CCGPUImageBaseFilter class]]) {
        ((CCGPUImageBaseFilter *)filter).time = 0.2f;
    }
    
    [self.picture addTarget:filter];
    [filter addTarget:self.imageView];
    
    // 还没被添加到界面上，放到下次runloop再执行渲染
    if (!self.superview) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.picture processImage];
        });
    } else {
        [self.picture processImage];
    }
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    self.selectView.hidden = !isSelect;
    self.titleLabel.textColor = isSelect ? ThemeColor : [UIColor whiteColor];
}

@end






