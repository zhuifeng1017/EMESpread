//
//  MathodTableViewCell.h
//  EMEFXTG
//
//  Created by Apple on 15/7/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MathodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ToPersonLabel;
@property (weak, nonatomic) IBOutlet UITextField *PeopleTF;
@property (weak, nonatomic) IBOutlet UITextField *PriceTF;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@end
