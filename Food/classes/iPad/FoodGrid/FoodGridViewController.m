//
//  FoodGridViewController.m
//  Food
//
//  Created by MDR on 13/07/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "FoodGridViewController.h"
#import "AppDelegate.h"

@interface FoodGridViewController ()

@end

@implementation FoodGridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialLoading
{

}

-(void) setUpGridData : (NSInteger)groupID
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.foodArrayData = [NSMutableArray array];
    BOOL isDuplicate = NO;
    for (id group_ID in [appDelegate.FoodDataDictionary allKeys]) {
        if([group_ID isEqualToString:[NSString stringWithFormat:@"%ld", (long)groupID]]){
            isDuplicate = YES;
        }
    }
    if (!isDuplicate) {
         self.foodArrayData = [appDelegate.FoodDataDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)groupID]];
    }
  

}
@end
