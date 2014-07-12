//
//  NavigationMenuViewController.h
//  ConfApp
//
//  Created by Dileep Mettu on 4/16/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationMenuViewController : UIViewController
{
    int selectedIndex;
}
@property (strong, nonatomic) IBOutlet UITableView *featureListTable;
@property (strong, nonatomic) IBOutlet UIImageView *cellImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellSection;

@end
