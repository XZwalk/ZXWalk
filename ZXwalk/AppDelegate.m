//
//  AppDelegate.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "AppDelegate.h"
#import "JumpToAnotherAppController.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSLog(@"sourceApplication: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    
    if ([sourceApplication isEqualToString:@"com.apple.mobilesafari"]){
        // 接受传过来的参数
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦"
                                                            message:[url query]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        
        JumpToAnotherAppController *jumpVC = [JumpToAnotherAppController new];
        
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:jumpVC];
        
        self.window.rootViewController = naVC;
        
        [self.window makeKeyAndVisible];
        
        
        
        
        [alertView show];
        
        return YES;
    }else{
        return NO;
    }
    
}


//经过验证已经废弃
// Will be deprecated at some point, please replace with application:openURL:sourceApplication:annotation:
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
//{
//    // 接受传过来的参数
//    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦"
//                                           message:text
//                                          delegate:nil
//                                 cancelButtonTitle:@"OK"
//                                 otherButtonTitles:nil];
//    [alertView show];
//    return YES;
//}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TabBarViewController *tabVC = [[TabBarViewController alloc] init];
    self.window.rootViewController = tabVC;
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
@end
