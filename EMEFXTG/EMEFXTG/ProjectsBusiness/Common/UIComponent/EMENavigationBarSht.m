//
//  EMENavigationBarSht.m
//  EMESHT
//
//  Created by xuanhr on 15/1/27.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "EMENavigationBarSht.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "AppCacheManager.h"
#import "AppUtils.h"

@interface EMENavigationBarSht ()
@property (weak, nonatomic) IBOutlet UIImageView *peoleBackImage;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *peopleIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation EMENavigationBarSht
- (void)configureViews {
    [super configureViews];
    [self configurePeopleImageHead];
}

- (void)reloadPeopleIcon {
    if ([[AppCacheManager sharedManager].loginUser.icon hasPrefix:@"http"]) {
        [_peopleIconBtn sd_setImageWithURL:[NSURL URLWithString:[AppCacheManager sharedManager].loginUser.icon] forState:UIControlStateNormal];
        _nameLabel.text = [AppCacheManager sharedManager].loginUser.name;
        _nameLabel.width = 162;
        _nameLabel.left = _peopleIconBtn.right + 10;
    } else {
        _nameLabel.text = [NSString stringWithFormat:@"欢迎来到%@APP", [AppUtils getAppDisplayName]];
        [_nameLabel sizeToFit];
        _nameLabel.left = _peopleIconBtn.right + 10;
        [_peopleIconBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    }
}

- (void)configurePeopleImageHead {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.peopleIconBtn = backButton;
    [backButton setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(20, 4, 51, 51)];
    backButton.layer.cornerRadius = backButton.frame.size.width / 2;
    backButton.clipsToBounds = YES;
    [backButton addTarget:self action:@selector(peopleIconClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];

    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_outline"]];
    self.peoleBackImage = backImageView;
    [backImageView sizeToFit];
    backImageView.left = 16;
    backImageView.top = 0;
    [self addSubview:backImageView];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 19, 174, 22)];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];

    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(60, 41, 14, 22);
    [editButton setImage:[UIImage imageNamed:@"dataedit"] forState:UIControlStateNormal];
    self.editButton = editButton;
    [self addSubview:editButton];

    if ([[AppCacheManager sharedManager].loginUser.icon hasPrefix:@"http"]) {
        [backButton sd_setImageWithURL:[NSURL URLWithString:[AppCacheManager sharedManager].loginUser.icon] forState:UIControlStateNormal];
        nameLabel.text = [AppCacheManager sharedManager].loginUser.name;
        nameLabel.width = 162;
        nameLabel.left = _peopleIconBtn.right + 10;
    } else {
        nameLabel.text = [NSString stringWithFormat:@"欢迎来到%@APP", [AppUtils getAppDisplayName]];
        [nameLabel sizeToFit];
        nameLabel.left = _peopleIconBtn.right + 10;
        [backButton setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    }
}

- (void)peopleIconClick:(UIButton *)sender {
}
@end
