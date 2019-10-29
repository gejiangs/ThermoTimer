//
//  BaseViewController.m
//  wook
//
//  Created by guojiang on 5/8/14.
//  Copyright (c) 2014年 guojiang. All rights reserved.
//

#import "BaseViewController.h"
#import "BottomMoreView.h"

@interface BaseViewController ()

@property (nonatomic, strong)   BottomMoreView *moreView;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout= UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[self.navigationController viewControllers] count] > 1) {
        [self resetBackBarButton];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg"]];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self languageKey:@"home_bg_top"]]];
    self.topImageView.hidden = YES;
    [self.view addSubview:self.topImageView];
    [self.topImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(20);
        make.height.offset(63);
    }];
    
    UILabel *homeLabel = [self.topImageView addLabelWithText:[self languageKey:@"HomeTitle"] color:[UIColor whiteColor]];
    homeLabel.font = [UIFont systemFontOfSize:20];
    [homeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topImageView);
        make.top.offset(12);
    }];
    
    self.moreButton = [self.view addButtonWithTitle:NSLocalizedString(@"MoreTitle", nil) target:self action:@selector(moreAction)];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"home_btn_down"] forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_moreButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.offset(0);
        make.height.offset(40);
        make.width.offset(200);
    }];
}

- (void)resetBackBarButton
{
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 40, 40);
    
    [leftBarButton setImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [leftBarButton addTarget:self action:@selector(viewWillBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space_item, item, nil];
    
}

-(void)viewWillBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:self.moreView];
}

-(void)pushViewControllerName:(NSString *)VCName
{
    [self pushViewControllerName:VCName animated:NO];
}

-(void)pushViewControllerName:(NSString *)VCName animated:(BOOL)animated
{
    id objClass = [[NSClassFromString(VCName) alloc] init];
    if (objClass == nil) {
        NSLog(@"ViewController:%@ is not exist", VCName);
        return;
    }
    
    [self.navigationController pushViewController:objClass animated:animated];
}

-(void)addLeftBarButton:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    self.navigationItem.leftBarButtonItem = button;
}

-(void)addRightBarButton:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)addRightImageButton:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 40, 40);
    [leftBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftBarButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space_item, item, nil];
}

-(void)setMoreViewHidden:(BOOL)hidden
{
//    self.moreButton.hidden = hidden;
}

-(void)moreAction
{
    WEAKSELF
    self.moreView = [[BottomMoreView alloc] init];
    _moreView.RowSelectedIndex = ^(NSInteger selectedIndex){
        [weakSelf pushMoreViewControllerWithIndex:selectedIndex];
        
        weakSelf.moreView = nil;
    };
    [_moreView showInView:self.view];
}

-(void)pushMoreViewControllerWithIndex:(NSInteger)index
{
    NSArray *VCNames = @[@"TimerViewController", @"SettingViewController", @"OperationViewController", @"AboutViewController"];
    
    [self pushViewControllerName:[VCNames objectAtIndex:index] animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
