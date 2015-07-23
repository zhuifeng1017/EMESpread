//
//  ReleaseArtitleViewController.m
//  EMEFXTG
//
//  Created by Apple on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "ReleaseArtitleViewController.h"
#import "AppUtils.h"
@interface ReleaseArtitleViewController ()
@property (copy, nonatomic) NSString *errorMessage;
@end

@implementation ReleaseArtitleViewController

- (void)viewDidLoad {
    self.title = @"发表文章";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AppUtils setLeftTextMargin:_EMETitleTF withLeftMargin:20];
    [AppUtils setLeftTextMargin:_EMEContentTF withLeftMargin:10];
    
    [self createButtons];
}

- (void)prepareData {
}

- (BOOL)fillData {
    return YES;
}

-(void)createButtons{
    NSArray *titles = @[@"添加红包",@"预览",@"发表"];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
