//
//  DetailsViewController.h
//  EMEFXTG
//
//  Created by Apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpreadItemCell.h"
#import "Product.h"
@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScr;
@property (weak, nonatomic) IBOutlet UITableView *ThankTableView;
@property (weak, nonatomic) Product *paramProduct;
//@property (nonatomic)NSInteger num;
@end


#pragma mark - DetailIntroduceCell
@interface DetailIntroduceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end


#pragma mark - DetailServiceCell
@interface DetailServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end