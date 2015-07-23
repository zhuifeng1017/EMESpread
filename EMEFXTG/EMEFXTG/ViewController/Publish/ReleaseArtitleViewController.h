//
//  ReleaseArtitleViewController.h
//  EMEFXTG
//
//  Created by Apple on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IStepViewControllerDatasource.h"

@interface ReleaseArtitleViewController : UIViewController <IStepViewControllerDatasource>
@property (weak, nonatomic) IBOutlet UITextField *EMETitleTF;
@property (weak, nonatomic) IBOutlet UITextField *EMEContentTF;
@property(nonatomic)NSInteger num;
@end
