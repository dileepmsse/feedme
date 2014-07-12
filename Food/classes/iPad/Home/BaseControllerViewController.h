//
//  BaseControllerViewController.h
//  ConfApp
//
//  Created by Dileep Mettu on 4/21/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RequestResponse.h"
@interface BaseControllerViewController : UIViewController
{
    UIView *theNavView;
    UILabel *notificationLabel;
    UIActivityIndicatorView *activityIndicator;
    UIPopoverController *notificationPopOver;
    RequestResponse *deRegisterToken;
    UIView *refreshView;
    BOOL isFromEventList;
    BOOL isKeyNotesSelected;
    
}
- (void) refreshData:(BOOL)fromEventList;
@end
