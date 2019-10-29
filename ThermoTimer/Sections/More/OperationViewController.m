//
//  OperationViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/10.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "OperationViewController.h"
#import "OperationCell.h"

@interface OperationViewController ()

@property (nonatomic, strong)   NSArray *titles;
@property (nonatomic, strong)   NSArray *details;

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LanguageKey(@"OperationTitle");
    
    [self setMoreViewHidden:YES];
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
    }];
    
    self.titles = @[[self languageKey:@"OperationTitle1"],
                    [self languageKey:@"OperationTitle2"],
                    [self languageKey:@"OperationTitle3"],
                    [self languageKey:@"OperationTitle4"],
                    [self languageKey:@"OperationTitle5"],
                    [self languageKey:@"OperationTitle6"]];
    
    self.details = @[[self languageKey:@"OperationDesc1"],
                     [self languageKey:@"OperationDesc2"],
                     [self languageKey:@"OperationDesc3"],
                     [self languageKey:@"OperationDesc4"],
                     [self languageKey:@"OperationDesc5"],
                     [self languageKey:@"OperationDesc6"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    OperationCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[OperationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.indexLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    cell.titleLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailLabel.text = [self.details objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        [cell setLogoImagePosition];
    }else if (indexPath.row == 5){
        [cell setTipImagePosition];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
        return 80;
    }
    return 110;
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
