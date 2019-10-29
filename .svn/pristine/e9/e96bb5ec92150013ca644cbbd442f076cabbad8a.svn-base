//
//  AlarmSettingViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/13.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "AlarmSettingViewController.h"

@interface AlarmSettingViewController ()

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation AlarmSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.alarmType == 1) {
        self.selectedIndex = [SystemManager shareManager].timerAlarm;
    }else if (self.alarmType == 2){
        self.selectedIndex = [SystemManager shareManager].tempAlarm;
    }
    
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
    }];
    self.tableView.tableFooterView = [self getFooterView];
    [self setMoreViewHidden:YES];
}

-(UIView *)getFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(200, 199, 204);
    [footerView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(-0.5);
        make.height.offset(0.5f);
    }];
    
    
    UIButton *startButton = [footerView addButtonWithTitle:NSLocalizedString(@"OK", nil) target:self action:@selector(saveAction:)];
    startButton.backgroundColor = APP_Yellow_Color;
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(120, 40));
        make.center.equalTo(footerView);
    }];
    
    return footerView;
}

-(void)saveAction:(UIButton *)sender
{
    if (self.alarmType == 1) {
        [SystemManager shareManager].timerAlarm = self.selectedIndex;
    }else if (self.alarmType == 2){
        [SystemManager shareManager].tempAlarm = self.selectedIndex;
    }
    
    [self.view showToastText:NSLocalizedString(@"SaveSuccess", nil) duration:1.5f];
    
    [[SystemManager shareManager] pauseMusic];
    
    [self dispatchTimerWithTime:1 block:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SystemManager shareManager].alarmList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = [[SystemManager shareManager].alarmList objectAtIndex:indexPath.row];
    
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_btn_marquee_yellow_pre"]];
    }else{
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_btn_marquee_yellow"]];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
    
    [[SystemManager shareManager] playAlarmWithIndex:self.selectedIndex];
    
    //播放10秒
    [self dispatchTimerWithTime:10 block:^{
        [[SystemManager shareManager] pauseMusic];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[SystemManager shareManager] pauseMusic];
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
