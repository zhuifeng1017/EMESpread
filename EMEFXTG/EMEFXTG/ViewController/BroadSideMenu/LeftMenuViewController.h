//
//  LeftMenuViewController.h
//  EMESHT
//
//  Created by appeme on 15/6/26.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)buttonClick:(UIButton *)sender;

@end
