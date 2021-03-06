//
//  BlueViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/10/27.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import "BlueViewController.h"
#import "BluetoothManager.h"
#import "MultipleDeviceViewController.h"
#import "SingleDeviceViewController.h"

@interface BlueCell : UITableViewCell

@end

@implementation BlueCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.textLabel.textColor = RGB(239, 134, 29);
    self.detailTextLabel.textColor = RGB(239, 134, 29);

    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGB(239, 134, 29);
    self.selectedBackgroundView = bgView;
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_btn_next_white"]];
    }else{
        self.textLabel.textColor = RGB(239, 134, 29);
        self.detailTextLabel.textColor = RGB(239, 134, 29);
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_btn_next_yellow"]];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_btn_next_white"]];
    }else{
        self.textLabel.textColor = RGB(239, 134, 29);
        self.detailTextLabel.textColor = RGB(239, 134, 29);
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_btn_next_yellow"]];
    }
}

@end

@interface BlueViewController ()

@property (nonatomic, assign)   BOOL needSearch;

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [Language key:@"BlueTitle"];
    
    self.edgesForExtendedLayout= UIRectEdgeNone;
    
    [self addRightBarButton:[self languageKey:@"Search"] target:self action:@selector(rightButtonClicked:)];
    
    self.tableView.tableFooterView = [UIView new];
    self.needSearch = NO;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //断开连接
    [[BluetoothManager shareManager] disConnect];
    [[SystemManager shareManager] clearTempArray];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.needSearch) {
        [self searchBlueDevice];
    }else{
        self.needSearch = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightButtonClicked:(id)sender
{
    [self searchBlueDevice];
}

-(void)searchBlueDevice
{
    [self.view showActivityView:[Language key:@"Searching"]];
    self.contentList = [NSMutableArray array];
    [self.tableView reloadData];
    [[BluetoothManager shareManager] startScanBlock:^(NSArray *peripheralArray) {
        
    } finally:^{
        self.contentList = [NSMutableArray arrayWithArray:[BluetoothManager shareManager].peripheralArray];
        [self.tableView reloadData];
        [self.view hiddenActivityView];
    }];
}

#pragma mark UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    BlueCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[BlueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    
    CBPeripheral *peripheral = [self.contentList objectAtIndex:indexPath.row];

    DeviceType type = [[SystemManager shareManager] getDeviceTypeWithBluename:peripheral.name];
    if (type == DeviceTypeOne) {
        cell.textLabel.text = [self languageKey:@"MiniGrill"];
    }else if (type == DeviceTypeTwo){
        cell.textLabel.text = [self languageKey:@"2ProbGrill"];
    }else if (type == DeviceTypeThree) {
        cell.textLabel.text = [self languageKey:@"3ProbGrill"];
    }else if (type == DeviceTypeFour) {
        cell.textLabel.text = [self languageKey:@"4ProbGrill"];
    }else{
        cell.textLabel.text = [self languageKey:@"UnknowType"];
    }
//    cell.textLabel.text = peripheral.name;
//    cell.detailTextLabel.text = [peripheral.identifier UUIDString];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *peripheral = [self.contentList objectAtIndex:indexPath.row];

    DeviceType type = [[SystemManager shareManager] getDeviceTypeWithBluename:peripheral.name];
    if (type == DeviceTypeUnknow) {
        [UIAlertView showTitle:[Language key:@"Tip"] message:[Language key:@"UnknowType"] buttonTitles:@[[Language key:@"OK"]] block:nil];
        return;
    }
    
    //设置当前蓝牙连接类型
    [SystemManager shareManager].currentDeviceType = type;
    
    [self.view showActivityView:[Language key:@"Connecting"]];
    [self dispatchTimerWithTime:10 block:^{
        [self.view hiddenActivityView];
    }];
    
    [[BluetoothManager shareManager] connect:peripheral block:^(BOOL success) {
        [self.view hiddenActivityView];
        if (success) {
            if (type == DeviceTypeOne) {
                SingleDeviceViewController *singleVC = [[SingleDeviceViewController alloc] init];
                [self.navigationController pushViewController:singleVC animated:YES];
            }else{
                MultipleDeviceViewController *multipleVC = [[MultipleDeviceViewController alloc] init];
                multipleVC.deviceType = type;
                [self.navigationController pushViewController:multipleVC animated:YES];
            }
        }else{
            [self.view showActivityView:[Language key:@"ConnectFailure"] hideAfterDelay:1.5];
        }
    }];
}

@end
