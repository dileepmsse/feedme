//
//  SplashViewController.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/3/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "SplashViewController.h"
#import "SWRevealViewController.h"
#import "WelcomeViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEnterForeground)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self registerNotification];
    //[self setupMovie];
    
	// Do any additional setup after loading the view, typically from a nib.
    SWRevealViewController *revealController = self.revealViewController;
    WelcomeViewController *controller=[WelcomeViewController new];
    [revealController setFrontViewController:controller animated:NO];
}
-(void)didEnterForeground
{
    [playerCtrl play];
}
-(void)setupMovie{
    NSString* moviePath ;
    moviePath = [[NSBundle mainBundle] pathForResource:@"testvideo" ofType:@"mov"];
    
    NSURL* movieURL = [NSURL fileURLWithPath:moviePath];
    
    playerCtrl =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    playerCtrl.controlStyle = MPMovieControlStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    playerCtrl.fullscreen = YES;
    playerCtrl.scalingMode = MPMovieScalingModeFill;
    playerCtrl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:playerCtrl.view];
    playerCtrl.view.backgroundColor = [UIColor blackColor];
    [playerCtrl play];
}
-(void)moviePlayBackDidFinish:(id)palyer
{
    [playerCtrl.view removeFromSuperview];
    
    //activate eventslist
    sleep(1);
    SWRevealViewController *revealController = self.revealViewController;
    WelcomeViewController *controller=[WelcomeViewController new];
    [revealController setFrontViewController:controller animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
