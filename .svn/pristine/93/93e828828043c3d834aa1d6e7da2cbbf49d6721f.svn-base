//
//  BannerView.h
//  TabDemo
//
//  Created by gejiangs on 14/12/8.
//  Copyright (c) 2014年 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickWithBlock)(NSInteger index);

@interface BannerScroll : UIScrollView

@end

@interface BannerScrollView : UIView

/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @return             创建本地图片，不自动切换
 */
-(id)initWithImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block;


/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建本地图片
 */
-(id)initWithImageNames:(NSArray *)imageNames autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;


/**
*  创建网络图片
*
*  @param imageNames    图片名字数组
*  @param block         点击block
*  @return              创建网络图片，不自动切换
*/
-(id)initWithImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block;

/**
 *  创建网络图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建网络图片
 */
-(id)initWithImageUrls:(NSArray *)imageUrls autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;

@end
