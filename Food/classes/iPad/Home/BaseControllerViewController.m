//
//  BaseControllerViewController.m
//  ConfApp
//
//  Created by Dileep Mettu on 4/21/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "BaseControllerViewController.h"
#import "SWRevealViewController.h"
#import "WelcomeViewController.h"
#import "UIColor+ColorModule.h"
#import "AppDelegate.h"
@interface BaseControllerViewController ()
@property UIPopoverController *favouritesQuickViewPC;
@property BOOL iskeyNoteSelected;

@end

@implementation BaseControllerViewController

- (void) refreshLatestData {
}
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
	// Do any additional setup after loading the view.
    
    //notifications to show new message indicator
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotifications:) name:@"updateNotifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoUpdate:) name:@"autoUpdate" object:nil];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    refreshView = [[UIView alloc] init];
    
    refreshView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    refreshView.frame = CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height+20);
    
    UILabel *refreshLabel = [[UILabel alloc] init];
    refreshLabel.text = @"Refreshing latest Data";
    refreshLabel.frame = CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height/2-75, 300, 50);
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.backgroundColor = [UIColor clearColor];
  //  [refreshView addSubview:refreshLabel];

  //  [refreshView addSubview:refreshBackgroundView];
    UISwipeGestureRecognizer *gestureSwipeOpenMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openMenuSwipeHandler)];
    [gestureSwipeOpenMenu setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:gestureSwipeOpenMenu];

    UISwipeGestureRecognizer *gestureSwipeCloseMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenuSwipeHandler)];
    [gestureSwipeCloseMenu setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:gestureSwipeCloseMenu];

    
    activityIndicator =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
//    [refreshView addSubview:activityIndicator];
//    
//    [self.view addSubview:refreshView];
    refreshView.hidden = TRUE;
       SWRevealViewController *revealController = self.revealViewController;

    // Do any additional setup after loading the view from its nib.
    theNavView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    theNavView.backgroundColor = [UIColor navBarColor];//[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    theNavView.tag = 100;
    
    
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(14, (theNavView.frame.origin.y+theNavView.frame.size.height-35), 23, 30)];
    [menuButton setImage:[UIImage imageNamed:@"reveal-icon"]forState:UIControlStateNormal];
    [menuButton.imageView setContentMode:UIViewContentModeScaleToFill];
    menuButton.tag=1;
    isKeyNotesSelected = NO;

    if (isKeyNotesSelected==YES) {
        
        [menuButton setImage:[UIImage imageNamed:@"notesTrash"]forState:UIControlStateNormal];
        [menuButton addTarget:revealController action:@selector(goBackButtonSelected:) forControlEvents:UIControlEventTouchUpInside ];
    }
    
    else{
    [menuButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside ];
    }
    
    [theNavView addSubview:menuButton];
    

    
    UILabel *navtitle=[[UILabel alloc]initWithFrame:CGRectMake(324, (theNavView.frame.origin.y+theNavView.frame.size.height+5)/2, 324, 22)];
    navtitle.tag=2;
    navtitle.textColor=[UIColor whiteColor];
    navtitle.backgroundColor=[UIColor clearColor];
    navtitle.textAlignment=NSTextAlignmentCenter;
    navtitle.center=CGPointMake(theNavView.center.x, navtitle.center.y);
    navtitle.font=[UIFont fontWithName:@"Helvetica" size:13.0];
    [theNavView addSubview:navtitle];
    
    
    UIButton *notification = [[UIButton alloc]initWithFrame:CGRectMake(800, (theNavView.frame.size.height+10)/2-3, 26, 26)];
    notification.tag=3;
    [notification setImage:[UIImage imageNamed:@"NavChatIconNew.png"]forState:UIControlStateNormal];
    [notification addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside ];
    [theNavView addSubview:notification];
    
    UIButton *polling = [[UIButton alloc]initWithFrame:CGRectMake(notification.frame.origin.x+notification.frame.size.width+16, (theNavView.frame.size.height+10)/2-3, 26, 26)];
    polling.tag=4;
    [polling setImage:[UIImage imageNamed:@"polls-lp-icon.png"]forState:UIControlStateNormal];
    [polling addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside ];
    [theNavView addSubview:polling];
    
    
    UIButton *agenda =[[UIButton alloc]initWithFrame:CGRectMake(polling.frame.origin.x+polling.frame.size.width+16, (theNavView.frame.size.height+10)/2-3, 26, 26)];
    
    [agenda setImage:[UIImage imageNamed:@"AgendaIcon.png"]forState:UIControlStateNormal];
    [agenda setTag:5];
    [agenda addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside ];
    [theNavView addSubview:agenda];
    
    NSLog(@"%f",agenda.frame.origin.x);
    UIButton *contact =[[UIButton alloc]initWithFrame:CGRectMake(agenda.frame.origin.x+agenda.frame.size.width+16, (theNavView.frame.size.height+10)/2-3, 26, 26)];
    
    [contact setImage:[UIImage imageNamed:@"NavRefreshNew.png"]forState:UIControlStateNormal];
    [contact setTag:6];
    [contact addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside ];
    [theNavView addSubview:contact];
   
    UIButton *logout =[[UIButton alloc]initWithFrame:CGRectMake(contact.frame.origin.x+contact.frame.size.width+16, (theNavView.frame.size.height+10)/2-3, 26, 26)];
    
    [logout setImage:[UIImage imageNamed:@"NavLogoutNew.png"]forState:UIControlStateNormal];
    [logout setTag:7];
    [logout addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside ];
    [theNavView addSubview:logout];

    
    notificationLabel=[[UILabel alloc]initWithFrame:CGRectMake(notification.frame.origin.x+notification.frame.size.width/2+5, notification.frame.origin.y-5,4,4)] ;
    notificationLabel.backgroundColor=[UIColor redColor];
    notificationLabel.textColor=[UIColor whiteColor];
    
    notificationLabel.hidden=FALSE;
    notificationLabel.font=[UIFont boldSystemFontOfSize:13];
    notificationLabel.textAlignment=NSTextAlignmentCenter;
    [notificationLabel sizeToFit];
  //  [self setRoundedView:7 nom:4];
    
    
    [theNavView addSubview:notificationLabel];
    
    
    
    [self.view addSubview:theNavView];
    

}

-(void)openMenuSwipeHandler
{
    SWRevealViewController *revealController = self.revealViewController;
    [revealController revealToggleAnimated:YES];



}
-(void)closeMenuSwipeHandler
{
    SWRevealViewController *revealController = self.revealViewController;
    [revealController rightRevealToggleAnimated:YES];


    
}

-(void) autoUpdate:(NSNotification*)notification
{
    [self refreshData:FALSE];
}
-(void) updateNotifications:(NSNotification*)notification
{
    NSNumber *msgCount = (NSNumber*)[notification object];
    [self setRoundedView:10 nom:[msgCount integerValue]];
}

-(void)setRoundedView:(float)newSize nom:(int)messages;
{
    if (messages == 0) {
        notificationLabel.hidden = TRUE;
    }
    else{
        notificationLabel.hidden = FALSE;
    }
    CGRect newFrame = CGRectMake(notificationLabel.frame.origin.x, notificationLabel.frame.origin.y, newSize*2, newSize*2);
    notificationLabel.frame = newFrame;
    notificationLabel.layer.cornerRadius =  newSize;
    notificationLabel.layer.masksToBounds = YES;
    notificationLabel.text=[NSString stringWithFormat:@"%d",messages];

   // roundedView.center = saveCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)showView:(UIButton *)sender
{
    
}
- (void) deRegisterToken
{
    AppDelegate *appDelegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    //appDelegate.isInsideEvent = FALSE;

    NSUserDefaults *store_token = [NSUserDefaults standardUserDefaults];
    NSString *token = [store_token stringForKey:@"token"];
}

- (void) cancelRefresh
{
    [activityIndicator stopAnimating];
//    activityIndicator.hidden = TRUE;
//    refreshView.hidden = TRUE;
    
    
    
    [refreshView removeFromSuperview];
    
    if (isFromEventList == TRUE) {
        isFromEventList = FALSE;
        SWRevealViewController *revealController = self.revealViewController;
        [revealController revealToggleAnimated:YES];
        
    }

    

}

- (void) updateFinished
{
    AppDelegate *appDelegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    //Update data in the app if to be updated
    [self cancelRefresh];

    [self refreshLatestData];
}
- (void) refreshData:(BOOL)FromEventList
{
    isFromEventList = FromEventList;
    //Parse data and update the app with update finished
    
    [refreshView addSubview:activityIndicator];
    
    [self.view addSubview:refreshView];
    
    [activityIndicator startAnimating];
    activityIndicator.hidden = FALSE;
    refreshView.hidden = FALSE;

}


@end
