//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by roki on 16/1/26.
//  Copyright © 2016年 roki. All rights reserved.
//

#import "AppDelegate.h"
#import "BSTableViewController.h"
#import "BSDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[BSTableViewController alloc] init]];
    
    self.window.rootViewController = nav;
    
    // 动态添加快捷启动
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAlarm];
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"shortcutTypeTwo" localizedTitle:@"two" localizedSubtitle:nil icon:icon userInfo:nil];
    [[UIApplication sharedApplication] setShortcutItems:@[item]];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    BSDetailViewController *detailVC = [[BSDetailViewController alloc] init];
    
    if ([shortcutItem.type isEqualToString:@"shortcutTypeOne"]) {
        detailVC.navTitle = @"one";
        
    } else if ([shortcutItem.type isEqualToString:@"shortcutTypeTwo"]) {
        detailVC.navTitle = @"two";
    }
    
    [nav pushViewController:detailVC animated:YES];
}
@end
