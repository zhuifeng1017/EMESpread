//
//  DetailsViewController.m
//  EMEFXTG
//
//  Created by Apple on 15/7/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DetailsViewController
static NSString *cellIdentifier1 = @"cellIdentifier1";
static NSString *cellIdentifier2 = @"cellIdentifier2";
static NSString *cellIdentifier3 = @"cellIdentifier3";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _ThankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _ThankTableView.delegate = self;
    _ThankTableView.dataSource = self;
    _ThankTableView.backgroundColor = [UIColor clearColor];
    UINib* nib1 = [UINib nibWithNibName:@"DetailIntroduceCell" bundle:nil];
    [_ThankTableView registerNib:nib1 forCellReuseIdentifier:cellIdentifier1];
    
    UINib* nib2 = [UINib nibWithNibName:@"DetailServiceCell" bundle:nil];
    [_ThankTableView registerNib:nib2 forCellReuseIdentifier:cellIdentifier2];
    
    UINib* nib3 = [UINib nibWithNibName:@"SpreadScoreCell" bundle:nil];
    [_ThankTableView registerNib:nib3 forCellReuseIdentifier:cellIdentifier3];
    
    [self.view addSubview:_ThankTableView];
    //[self createButtons];
}

//-(void)createButtons{
//    NSArray *titles = @[@"深粉科技",@"购买",@"推荐给好友"];
//    for (NSInteger i=0; i<titles.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake((320*i)/3, self.view.bounds.size.height-38, 320/3, 38);
//        [btn setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setBackgroundColor:[UIColor blackColor]];
//        [btn setBackgroundImage:[UIImage ImageWithUIcolor:[UIColor redColor]] forState:UIControlStateSelected];
//        btn.tag = 101+i;
//        [btn addTarget:self action:@selector(EMEClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//        if (btn.tag == 101) {
//            _num = 101;
//            btn.selected = YES;
//        }
//        
//    }
//}
//-(void)EMEClick:(UIButton *)btn{
//    UIButton *button = (UIButton *)[self.view viewWithTag:_num];
//    button.selected = NO;
//    btn.selected = YES;
//    _num = btn.tag;
//}

#pragma TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DetailIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.title1.text = @"活动";
        return cell;
    }else if(indexPath.section == 1){
        DetailServiceCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell2.backgroundColor = [UIColor clearColor];
        cell2.title1.text = @"运费";
        return cell2;
    }else{
        SpreadScoreCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3 forIndexPath:indexPath];
        cell3.backgroundColor = [UIColor clearColor];
        cell3.contentLabel.text = @"小王感谢李四的推荐：东西很好";
        cell3.dateTimeLabel.text = @"6月27日 18：00";
        [cell3.rateView setFullStarImage:[UIImage imageNamed:@"rate_start1.png"]];
        [cell3.rateView setEmptyStarImage:[UIImage imageNamed:@"rate_start2.png"]];
        return cell3;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 300, 2)];
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 45;
    }else{
        return 40;
    }
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if(section == 1){
        return 3;
    }else{
        return 2;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end






#pragma mark - DetailIntroduceCell

@implementation DetailIntroduceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



#pragma mark - DetailServiceCell

@implementation DetailServiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


