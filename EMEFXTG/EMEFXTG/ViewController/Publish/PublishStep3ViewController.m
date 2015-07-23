//
//  MarketingStrategyViewController.m
//  EMEFXTG
//
//  Created by Apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "PublishStep3ViewController.h"
#import "MathodTableViewCell.h"
@interface PublishStep3ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PublishStep3ViewController
static NSString *cellIdentifier = @"cellIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _mathodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mathodTableView.delegate = self;
    _mathodTableView.dataSource = self;
    
    UINib* nib = [UINib nibWithNibName:@"MathodTableViewCell" bundle:nil];
    [_mathodTableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_mathodTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MathodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.ToPersonLabel.text = @"满多少人";
    cell.PriceLabel.text = @"是什么价格";
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 30;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareData {
    //    _titleTextField.text = _params[@"title"];
    //    _summaryTextView.text = _params[@"summary"];
}

- (BOOL)fillData {
    //    _params[@"title"] = _titleTextField.text;
    //    _params[@"summary"] = _summaryTextView.text;
    
    return YES;
}


@end
