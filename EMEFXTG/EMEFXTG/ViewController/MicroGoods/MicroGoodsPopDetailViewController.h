//
//  MicroGoodsPopDetailViewController.h
//  EMEFXTG
//
//  Created by appeme on 15/6/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MicroGoodsPopDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
- (IBAction)closeClick:(id)sender;

@end
