//
//  BottomMoreView.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/11.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "BottomMoreView.h"

#define Table_Row_Height 40.f

@interface MoreViewCell : UITableViewCell

@end

@implementation MoreViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.imageView.frame;
    rect.size.height = 30.f;
    rect.size.width = 30.f;
    rect.origin.y = (self.contentView.frame.size.height-rect.size.height)/2.f;
    
    self.imageView.frame = rect;
    
    rect = self.textLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20.f;
    self.textLabel.frame = rect;
}

@end


@interface BottomMoreView ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isShow;
}

@property (nonatomic, strong)   UIButton *handlerView;
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   UIButton *titleView;
@property (nonatomic, assign)   NSInteger rowCount;
@property (nonatomic, assign)   BOOL isHome;

@end

@implementation BottomMoreView

-(id)initWithIsHome:(BOOL)isHome
{
    if (self = [super init]) {
        self.isHome = isHome;
        [self initUI];
    }
    return self;
}

-(id)init
{
    if (self = [super init]) {
        self.isHome = NO;
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.rowCount = 4;
    self.backgroundColor = [UIColor clearColor];
    
    self.handlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    _handlerView.backgroundColor = [UIColor clearColor];
    _handlerView.hidden = NO;
    [_handlerView addTarget:self action:@selector(closeMoreView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_handlerView];
    
    [_handlerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self).offset(0);
    }];
    
    [self setTableViewStyle:UITableViewStylePlain];
    self.tableView.tableHeaderView = [self getHeaderView];
}

-(void)setTableViewStyle:(UITableViewStyle)tableViewStyle
{
    if (self.tableView != nil) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:self.tableView];
    [_tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(Table_Row_Height*(self.rowCount+1));
        make.bottom.offset(0);
        make.centerX.equalTo(self);
    }];
}

#pragma mark UITableHeaderView
-(UIView *)getHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, Table_Row_Height)];
    headerView.backgroundColor = [UIColor clearColor];
    
    self.titleView = [headerView addButtonWithTitle:NSLocalizedString(@"MoreClose", nil) target:self action:@selector(headerAction:)];
    [_titleView setBackgroundImage:[UIImage imageNamed:@"home_btn_down"] forState:UIControlStateNormal];
    [_titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_titleView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    
    return headerView;
}

#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    MoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[MoreViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.backgroundColor = RGB(129, 130, 133);
    
    NSArray *imageNames = @[@"nav_icon_setting",@"nav_icon_operation",@"nav_icon_search",@"nav_icon_warn"];
    NSArray *titleNames = @[[self languageKey:@"MoreSetting"],
                            [self languageKey:@"MoreOperation"],
                            [self languageKey:@"MoreSearch"],
                            [self languageKey:@"MoreAbout"]];
    
    if (!self.isHome) {
        imageNames = @[@"nav_icon_timer",@"nav_icon_setting",@"nav_icon_operation",@"nav_icon_warn"];
        titleNames = @[[self languageKey:@"MoreTimer"],
                       [self languageKey:@"MoreSetting"],
                       [self languageKey:@"MoreOperation"],
                       [self languageKey:@"MoreAbout"]];
    }
    
    cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    cell.textLabel.text = [titleNames objectAtIndex:indexPath.row];
    
    UIView *selectedBGView = [UIView new];
    selectedBGView.backgroundColor = RGB(68, 69, 70);
    
    cell.selectedBackgroundView = selectedBGView;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Table_Row_Height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.RowSelectedIndex) {
        self.RowSelectedIndex(indexPath.row);
    }
    
    isShow = NO;
    [self show:NO];
    
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(Table_Row_Height);
    }];
    
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(Table_Row_Height * self.rowCount);
    }];
}

#pragma mark Action
-(void)headerAction:(UIButton *)sender
{
    [self show:NO];
}

-(void)closeMoreView
{
    [self show:NO];
}

-(void)show:(BOOL)show
{
    isShow = show;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (!show) {
            [self removeFromSuperview];
        }
    }];
}


- (void)updateConstraints
{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(Table_Row_Height*(self.rowCount+1));
        make.centerX.equalTo(self);
        if (isShow) {
            make.bottom.equalTo(self).offset(0);
        }else{
            make.bottom.equalTo(self).offset(Table_Row_Height * self.rowCount);
        }
    }];
    
    [super updateConstraints];
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    [self dispatchTimerWithTime:0.1 block:^{
        [self show:YES];
    }];
}

@end
