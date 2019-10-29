//
//  AboutViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/10.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LanguageKey(@"AboutTitle");
    
    self.boxView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.boxView.layer.borderWidth = 0.5f;
    
    self.versionLabel.text = [NSString stringWithFormat:@"%@ %@", [self languageKey:@"Version"], AppVersionNumber];
    self.emailLabel.text = [NSString stringWithFormat:@"%@info@cnkaitai.com",[self languageKey:@"Email"]];
    self.websiteLabel.text = [self languageKey:@"Website"];
    
    [self setMoreViewHidden:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)showLog:(UIButton *)sender
{
//    [self pushViewControllerName:@"LogViewController" animated:YES];
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
