//
//  AppDelegate.h
//  ConfApp
//
//  Created by Dileep Mettu on 4/16/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestResponse.h"
@class SWRevealViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIBackgroundTaskIdentifier bgTask;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property BOOL isDownloadInProgress;

//Declare variables which are required through out the app

@end
