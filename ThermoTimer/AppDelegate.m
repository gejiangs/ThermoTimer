//
//  AppDelegate.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/10.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, strong)   NSTimer *backgroundTimer;

@end

@implementation AppDelegate


- (void)umengTrack
{
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:@"5704b1a067e58e6c38001654" reportPolicy:(ReportPolicy) REALTIME channelId:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self umengTrack];
    
    //添加后台播放代码：
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[SystemManager shareManager] registerNotificationSetting];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //未激活状态
    if (application.applicationState == UIApplicationStateInactive) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self.bgTask = [application beginBackgroundTaskWithExpirationHandler:nil];
    
    if (self.backgroundTimer) {
        [self.backgroundTimer invalidate];
        self.backgroundTimer = nil;
    }
    self.backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(tik) userInfo:nil repeats:YES];
}

- (void)tik{
    
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] < 61.0) {
        self.bgTask =[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        [[SystemManager shareManager] playBackgroundMusic];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //应用切换回前台
    [application endBackgroundTask:self.bgTask];
    self.bgTask = UIBackgroundTaskInvalid;
    
    if (self.backgroundTimer) {
        [self.backgroundTimer invalidate];
        self.backgroundTimer = nil;
    }
    [[SystemManager shareManager] pauseBackgroundMusic];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
