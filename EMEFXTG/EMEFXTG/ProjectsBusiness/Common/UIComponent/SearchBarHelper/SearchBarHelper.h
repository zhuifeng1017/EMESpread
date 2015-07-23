//
//  SearchBarHelper.h
//  EMESHT
//
//  Created by appeme on 15/3/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchBarHelper : NSObject {
    BOOL hasInitNotifier;
}
@property (assign, nonatomic) BOOL isManualSearch;
@property (assign, nonatomic) BOOL isDelete;//current display delete icon or search icon
@property (weak, nonatomic) UITextField *textField;
@property (weak, nonatomic) UIButton *searchButton;
@property (copy, nonatomic) NSString *searchIcon;
@property (copy, nonatomic) NSString *deleteIcon;

- (void)setTextField:(UITextField *)textField searchButton:(UIButton *)searchButton;
- (void)searchHasResult:(BOOL)hasResult;
@end
