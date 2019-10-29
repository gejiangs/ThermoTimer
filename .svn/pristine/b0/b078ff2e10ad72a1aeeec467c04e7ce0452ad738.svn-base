//
//  FoodChoiceViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "FoodChoiceViewController.h"
#import "FoodCell.h"
#import "AddFoodViewController.h"
#import "FoodSettingViewController.h"
#import "FoodModel.h"
#import "TMCache.h"
#import "SingleDeviceViewController.h"
#import "MultipleDeviceViewController.h"

@interface FoodChoiceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)   NSMutableArray *contentList;
@property (nonatomic, assign)   NSInteger editIndexRow;

@end

@implementation FoodChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LanguageKey(@"FoodTitle");
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[FoodCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.contentList = [NSMutableArray array];
    
    //取出缓存（自定义添加的）
    self.contentList = [self getCustomModels];
    
    [self setRightButton];
    
    for (int i=0; i<8; i++) {
        FoodModel *model = [[FoodModel alloc] init];
        model.type = i;
        [self.contentList addObject:model];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self setRightButton];
}

-(void)setRightButton
{
    NSArray *customs = [self getCustomModels];
    if ([customs count] == 4) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        [self addRightImageButton:@"btn_add" target:self action:@selector(addGood:)];
    }
}

-(NSMutableArray *)getCustomModels
{
   return [NSMutableArray arrayWithArray:[[TMCache sharedCache] objectForKey:CustomFoodModel]];
}

-(void)addGood:(UIBarButtonItem *)sender
{
    AddFoodViewController *addVC = [[AddFoodViewController alloc] init];
    addVC.foodChoiceViewController = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)insertFoodModel:(FoodModel *)model
{
    if (model != nil) {
        [self.contentList insertObject:model atIndex:0];
        [self.collectionView reloadData];
        
        NSMutableArray *customs = [self getCustomModels];
        [customs insertObject:model atIndex:0];
        
        [[TMCache sharedCache] setObject:customs forKey:CustomFoodModel];
        
        [self setRightButton];
    }
}

-(void)replaceFirstFoodModel:(FoodModel *)model
{
    FoodModel *_model = [self.contentList objectAtIndex:self.editIndexRow];
    if (_model.type != -1) {
        return;
    }
    [self.contentList replaceObjectAtIndex:self.editIndexRow withObject:model];
    [self.collectionView reloadData];
    
    NSMutableArray *customs = [self getCustomModels];
    [customs replaceObjectAtIndex:self.editIndexRow withObject:model];
    
    [[TMCache sharedCache] setObject:customs forKey:CustomFoodModel];
}

-(void)removeCustomFoodModel
{
    FoodModel *model = [self.contentList objectAtIndex:self.editIndexRow];
    if (model.type != -1) {
        return;
    }
    
    //删除自定义温度，同时也清除设置的温度
    UIViewController *rootVC = [self.navigationController.viewControllers objectAtIndex:2];
    if ([rootVC isKindOfClass:[MultipleDeviceViewController class]]) {
        MultipleDeviceViewController *multiple = (MultipleDeviceViewController *)rootVC;
        [multiple clearCustomValueWithTag:model.tag];
        
    }else if ([rootVC isKindOfClass:[SingleDeviceViewController class]]){
        SingleDeviceViewController *multiple = (SingleDeviceViewController *)rootVC;
        [multiple clearCustomValueWithTag:model.tag];
    }
    
    [self.contentList removeObjectAtIndex:self.editIndexRow];
    [self.collectionView reloadData];
    
    NSMutableArray *customs = [self getCustomModels];
    [customs removeObjectAtIndex:self.editIndexRow];
    
    [[TMCache sharedCache] setObject:customs forKey:CustomFoodModel];
}

//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.contentList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell sizeToFit];
    
    FoodModel *model = [self.contentList objectAtIndex:indexPath.row];
    [cell setCellInfo:model];
    
    cell.delButton.tag = indexPath.row;
    [cell.delButton addTarget:self action:@selector(deleteFood:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = (self.collectionView.frame.size.width - 30)/2;
    CGFloat h = w;
    
    return CGSizeMake(w, h);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodModel *model = [self.contentList objectAtIndex:indexPath.row];
    if (model.type == -1) {
        self.editIndexRow = indexPath.row;
        AddFoodViewController *addVC = [[AddFoodViewController alloc] init];
        addVC.foodModel = model;
        addVC.foodChoiceViewController = self;
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        FoodSettingViewController *settingVC = [[FoodSettingViewController alloc] init];
        settingVC.foodModel = model;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark UIButton Clicked
-(void)deleteFood:(UIButton *)sender
{
    self.editIndexRow = sender.tag;
    FoodModel *model = [self.contentList objectAtIndex:self.editIndexRow];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tip", nil)
                                                    message:[NSString stringWithFormat:NSLocalizedString(@"SureDeleteFood", nil), model.name]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self removeCustomFoodModel];
            
            [self setRightButton];
        }
    }];
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
