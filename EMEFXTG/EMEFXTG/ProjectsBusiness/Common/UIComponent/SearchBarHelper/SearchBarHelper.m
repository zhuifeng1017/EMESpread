//
//  SearchBarHelper.m
//  EMESHT
//
//  Created by appeme on 15/3/23.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "SearchBarHelper.h"

@implementation SearchBarHelper
- (void)setTextField:(UITextField *)textField searchButton:(UIButton *)searchButton {

    if (!hasInitNotifier) {
        hasInitNotifier = YES;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    }

    _textField = textField;
    _searchButton = searchButton;
}

- (void)textFiledEditChanged:(NSNotification *)notification {
    [self setDeleteStyle:NO];
}

- (void)searchHasResult:(BOOL)hasResult {
    if (hasResult) {
        if (_textField.text.length == 0) {
            [self setDeleteStyle:NO];
        } else {
            [self setDeleteStyle:YES];
        }
    } else {
        [self setDeleteStyle:NO];

        if (_isManualSearch) {
            [_textField becomeFirstResponder];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您搜索的内容无结果，请重新输入。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (void)setDeleteStyle:(BOOL)delete {
    if (delete) {
        [_searchButton setImage:[UIImage imageNamed:_deleteIcon ?: @"edit_btn_del"] forState:UIControlStateNormal];
        _isDelete = YES;
    }
    else {
        [_searchButton setImage:[UIImage imageNamed:_searchIcon ?: @"btn_search"] forState:UIControlStateNormal];
        _isDelete = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
