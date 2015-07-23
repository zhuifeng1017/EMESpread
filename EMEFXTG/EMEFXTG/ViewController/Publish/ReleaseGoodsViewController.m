//
//  ReleaseDoodsViewController.m
//  EMEFXTG
//
//  Created by Apple on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "ReleaseGoodsViewController.h"
#import "AppUtils.h"
#import "ReleaseArtitleViewController.h"
#import "ImagePickAndUploader.h"
@interface ReleaseGoodsViewController ()
@property (copy, nonatomic) NSString *errorMessage;
@property (strong, nonatomic) ImagePickAndUploader *imagePickAndUploader;
@end

@implementation ReleaseGoodsViewController

- (void)viewDidLoad {
    self.title = @"发布商品";
    [super viewDidLoad];
    
    [AppUtils setLeftTextMargin:_EMETitleTF withLeftMargin:10];
    [AppUtils setLeftTextMargin:_EMEIntroductionTF withLeftMargin:10];
    [AppUtils setLeftTextMargin:_EMENumberTF withLeftMargin:10];
    [AppUtils setLeftTextMargin:_EMEPriceTF withLeftMargin:10];
    [self createButtons];
    [self configureData];
}

- (void)configureData {
    _imagePickAndUploader = [[ImagePickAndUploader alloc] init];
    _imagePickAndUploader.needCompress = YES;
    _imagePickAndUploader.aspectRatio = 1;
    _imagePickAndUploader.keepingCropAspectRatio = YES;
}

- (void)prepareData {
}

- (BOOL)fillData {
    return YES;
}

-(void)createButtons{
    NSArray *titles = @[@"添加优惠",@"预览",@"发表"];
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((320*i)/3, self.view.bounds.size.height-38, 320/3, 38);
        [btn setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor blackColor]];
        [btn setBackgroundImage:[UIImage ImageWithUIcolor:[UIColor redColor]] forState:UIControlStateSelected];
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(EMEClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (btn.tag == 101) {
            _num = 101;
            btn.selected = YES;
        }

    }
}
-(void)EMEClick:(UIButton *)btn{
    UIButton *button = (UIButton *)[self.view viewWithTag:_num];
    button.selected = NO;
    btn.selected = YES;
    _num = btn.tag;
    switch (btn.tag) {
        case 103:
        {
            ReleaseArtitleViewController *ctl = [[ReleaseArtitleViewController alloc]init];
            [self.navigationController pushViewController:ctl animated:NO];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)uploadImageClick:(id)sender {
    [_imagePickAndUploader showPickDialog:self imageView:self.startImageBtn];
}
@end
