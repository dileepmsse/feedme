//
//  navigationCell.h
//  ConfApp
//
//  Created by sesa249801 on 6/23/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface navigationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *menuItemImage;
@property (strong, nonatomic) IBOutlet UILabel *menuItemTitle;
@property (strong, nonatomic) UIFont *menuItemsFont;
@end
