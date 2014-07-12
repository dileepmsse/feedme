//
//  WelcomeViewController.m
//  Food
//
//  Created by MDR on 13/07/14.
//  Copyright (c) 2014 Pradeepkumargm. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    
    // Do any additional setup after loading the view from its nib.
    UILabel *titleLabel = [self.view viewWithTag:2];
    titleLabel.text = @"Welcome";
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)HandleNavigationButton:(UIButton *)sender {
    
    
    NSInteger tag = sender.tag;
    switch (tag) {
        case 100:
        {}
    }
}
@end
