//
//  FoodGridViewController.h
//  Food
//
//  Created by MDR on 13/07/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControllerViewController.h"

@interface FoodGridViewController : BaseControllerViewController
@property NSMutableArray *foodArrayData;
-(void) setUpGridData : (NSInteger)groupID;
@end
