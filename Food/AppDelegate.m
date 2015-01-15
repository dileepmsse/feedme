//
//  AppDelegate.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/13/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "SplashViewController.h"
#import "NavigationMenuViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window = window;
    NSLog(@"Entered appdelegate didFinishLaunchingWithOptions");
    SplashViewController *frontViewController = [[SplashViewController alloc] init];

	NavigationMenuViewController *rearViewController = [[NavigationMenuViewController alloc] init];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:rearViewController frontViewController:frontViewController];

	self.viewController = mainRevealController;
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
    
    UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        }];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"app terminated");
}
#pragma mark - Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //register the token using the webservice.
    const unsigned *tokenBytes = [deviceToken bytes];
    
//    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Remote" message:@"remote" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [view show];
    NSLog(@"token - %@",deviceToken);
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken - %@", hexToken);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:hexToken forKey:@"token"];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError - %@", error.localizedDescription);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"didReceiveRemoteNotification");

}

- (void) requestResponseDidRecieveData:(NSString *) resultString withService:(RequestResponseServiceType)serviceType
{
    NSLog(@"result - %@",resultString);
  //refresh messages

}
@end
