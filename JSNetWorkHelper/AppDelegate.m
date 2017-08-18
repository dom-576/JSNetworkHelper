//
//  AppDelegate.m
//  JSNetWorkHelper
//
//  Created by lijie on 2017/8/17.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import "AppDelegate.h"
#import "JSNetWorkHelper.h"
#import "MBProgressHUD+JSExtension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JSNetWorkHelper checkingNetworkResult:^(NetworkStatus status) {
        
        switch (status) {
            case StatusUnknown: // 未知网络
                //[MBProgressHUD showAutoMessage:@"未知网络" inView:kWindow];
                NSLog(@"未知网络");
                break;
                
            case StatusNotReachable: // 没有网络(断网)
                [MBProgressHUD showAutoMessage:@"网络未连接,请检查" inView:_window];
                NSLog(@"没有网络(断网)");
                break;
                
            case StatusReachableViaWWAN: // 手机自带网络
                [MBProgressHUD showAutoMessage:@"当前网络为蜂窝网络" inView:_window];

                NSLog(@"手机自带蜂窝网络");
                break;
                
            case StatusReachableViaWiFi: // WIFI
            {
                [MBProgressHUD showAutoMessage:@"当前网络为WiFi" inView:_window];
                NSLog(@"WIFI");
            }
                break;
        
        }
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
