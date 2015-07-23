//
//  ChooseBusinessViewController.m
//  EMESHT
//
//  Created by xuanhr on 14-10-31.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "ChoosePopViewController.h"

@interface ChoosePopViewController ()
@property (copy, nonatomic) ChoosePopViewSingleSelectionBlock choosePopViewSingleSelectionBlock;
@property (copy, nonatomic) ChoosePopViewMutliSelectionBlock choosePopViewMutliSelectionBlock;
@end

@implementation ChoosePopViewController

NSString *cellIndentifier = @"cellIndentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _selectedIndex = -1;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    int height = 44 + self.displayTextArray.count * 40;
    int maxHeight = [UIScreen mainScreen].bounds.size.height * 5 / 6;
    if (height > maxHeight) {
        int count = (maxHeight - 44) / 40;
        height = 44 + count * 40;
    }
    self.view.height = height + 7;

    self.titleLabel.text = self.titleText;
    if (self.saveButtonText.length > 0) {
        [self.saveClickButton setTitle:self.saveButtonText forState:UIControlStateNormal];
    }

    if (!_selectedIndexArray) {
        _selectedIndexArray = [NSMutableArray array];
    }

    self.saveButton.hidden = !self.multiSelection;

    UINib *nib = [UINib nibWithNibName:@"ChoosePopViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
    [_tableView setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_displayTextArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];

    ChoosePopViewCell *cell = (ChoosePopViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.titleLabel.text = _displayTextArray[row];

    if (_multiSelection) {
        [cell.chooseImage setImage:[UIImage imageNamed:([_selectedIndexArray containsObject:@(row)] ? @"common_checkbox_selected" : @"common_checkbox_noselected")]];
    } else {
        [cell.chooseImage setImage:[UIImage imageNamed:(row == _selectedIndex ? @"page_edit_radiobox_selected" : @"page_edit_radiobox_noselected")]];
    }

    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;

    if (self.multiSelection) {
        if ([_selectedIndexArray containsObject:@(_selectedIndex)]) {
            [_selectedIndexArray removeObject:@(_selectedIndex)];
        } else {
            [_selectedIndexArray addObject:@(_selectedIndex)];
        }

        [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        if (_choosePopViewSingleSelectionBlock) {
            _choosePopViewSingleSelectionBlock(_selectedIndex);
        }

        [(EMEPopViewController *)self.parentViewController dismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveClick:(id)sender {
    if (_choosePopViewMutliSelectionBlock) {

        NSArray *newArray = [_selectedIndexArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];

        _choosePopViewMutliSelectionBlock(newArray);
    }

    [(EMEPopViewController *)self.parentViewController dismiss];
}
@end

@implementation ChoosePopViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
