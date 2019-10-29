//
//  LogViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 16/1/15.
//  Copyright © 2016年 gejiangs. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@property (nonatomic, strong)   UITextView *textView;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"log";
    
    [self initUI];
    
    [self loadLog];
}

-(void)initUI
{
    [self setMoreViewHidden:YES];
    
    self.textView = [self.view addTextViewWithDelegate:self font:[UIFont systemFontOfSize:17]];
    _textView.editable = NO;
    _textView.font = [UIFont systemFontOfSize:13];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(64);
    }];
}


-(void)loadLog
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:@"log.txt"];
    
    NSMutableArray *logData = [NSMutableArray arrayWithContentsOfFile:configFile];
    
    NSMutableString *text = [[NSMutableString alloc] init];
    
    for (NSString *item in logData) {
        [text appendFormat:@"%@\n", item];
    }
    
    self.textView.text = text;
    NSLog(@"log:%@", text);
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
