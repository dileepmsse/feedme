//
//  NavigationMenuViewController.m
//  ConfApp
//
//  Created by Dileep Mettu on 4/16/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "NavigationMenuViewController.h"
#import "SWRevealViewController.h"
#import "WelcomeViewController.h"
#import "navigationCell.h"
#import "AppDelegate.h"
@interface NavigationMenuViewController ()

@end

@implementation NavigationMenuViewController

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
    
    

    //initialize
   // SWRevealViewController *parentRevealController = self.revealViewController;

    //UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LPBG-v-repeat.png"]];
    //self.featureListTable.backgroundView = bgView;


    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    imageView.image = [UIImage imageNamed:@"LPBG-v-repeat.png"];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.navigationController.view insertSubview:imageView atIndex:0];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row == 0) {
//        return 65;
//    }
    
    return 108;
}









- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    navigationCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	NSInteger row = indexPath.row;
    NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"navigationCell" owner:self options:nil];
    
	//if (nil == cell)

        cell= [nib objectAtIndex:0];

//    cell.textLabel.font = [UIFont systemFontOfSize:13];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    for(UIView *view in cell.contentView.subviews)
//    {
//        if([view isKindOfClass:[UILabel class]])
//            [view removeFromSuperview];
//         }
//    
//    
    
    

//    if (row == 0) {
//        
//        
//        
//        NSLog(@"x- %f y - %f w - %f h - %f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, cell.frame.size.width, 65);
//        CALayer *TopBorder = [CALayer layer];
//        TopBorder.frame = CGRectMake(0.0f,64.5f, cell.frame.size.width, 0.5f);
//        TopBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
//        [cell.layer addSublayer:TopBorder];
//        UILabel *label = [[UILabel alloc] init];
//        
//        
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
//        NSMutableArray *eventslistArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        
//        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        NSDictionary *dict;
//        for (dict in eventslistArray)
//        {
//            if ([[dict valueForKey:@"EventId"] integerValue] == appDelegate.eventID)
//            {
//                NSString *eventname = [dict valueForKey:@"EventName"];
//                label.text = eventname;
//                
//                break;
//                
//            }
//        }
//
//        
//        
//        
//        label.frame = CGRectMake(view.frame.origin.x+15, view.frame.origin.y+30, view.frame.size.width, view.frame.size.height-30);
//        label.textColor = [UIColor whiteColor];
//        [view addSubview:label];
//        [cell.contentView addSubview:view];
//        
//        
//       // cell.textLabel.text = @"ESRI";

//    }
//    
//    
//    
//  
    
    
    
//    
//    reusableIdentifier= @"PollingCell3";
//    cellPolling=[tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
//    
//    PollingData *tempPollingData= [[PollingData alloc]init];
//    tempPollingData= [pollList objectAtIndex:indexPath.row];
//    ///changes from here
//    //        if(!cellPolling)
//    //        {
//    
//    ////////MAJOR//////////////////////
//    NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"PollingCellGeneralView" owner:self options:nil];
//    
//    
//    switch (tempPollingData.ePollingQuestionType) {
//        case 0:
//        {
//            if (tempPollingData.isAnswered) {///////////////feed back answered
//                cellPolling= [nib objectAtIndex:3];
    
    
//    if (row==0) {
//        cell.menuItemImage.image=nil;
//        cell.menuItemTitle.text=@"";
//    }
//    
  //  UIImage *thumbnail;
    
    cell.menuItemTitle.textAlignment= NSTextAlignmentCenter;
	if (row == 0)
	{
         NSLog(@"x- %f y - %f w - %f h - %f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
		cell.menuItemTitle.text = @"Welcome";
        cell.menuItemImage.image=[UIImage imageNamed:@"menuWelcome"];
        
//        if (selectedIndex == row) {
//           // thumbnail = [UIImage imageNamed:@"welcome_icon_active.png"];
//            cell.textLabel.textColor = [UIColor sidePanelActiveColor];
//          //  cell.menuItemImage.image=[UIImage imageNamed:@"menuPolling"];
//            
//        }
//        else{
//       // thumbnail = [UIImage imageNamed:@"welcome_icon.png"];
//        }
	}
	else if (row == 1)
	{
        cell.menuItemImage.image=[UIImage imageNamed:@"menuAgenda"];
		cell.menuItemTitle.text= @"Agenda";
        
        
//        if (selectedIndex == row) {
//           // thumbnail = [UIImage imageNamed:@"agenda-lp-icon_active.png"];
//           // cell.textLabel.textColor = [UIColor sidePanelActiveColor];
//        }
//        else{
//       // thumbnail =  [UIImage imageNamed:@"agenda-lp-icon.png"];
//        }
//        
//      //  cell.menuItemImage=[UIImage imageNamed:@"welcome_icon_active.png"];
	}
	else if (row == 2)
	{
		cell.menuItemTitle.text = @"Attendees";
        
        cell.menuItemImage.image=[UIImage imageNamed:@"menuAttendees"];
//        if (selectedIndex == row) {
//           // thumbnail = [UIImage imageNamed:@"attendee-lp-icon_active.png"];
//         //   cell.textLabel.textColor = [UIColor sidePanelActiveColor];
//
//        }
//        else{
//       // thumbnail =  [UIImage imageNamed:@"attendee-lp-icon.png"];
//        }
//        
//        
//        cell.menuItemImage.image=[UIImage imageNamed:@"welcome_icon_active.png"];

	}
    else if (row == 3)
	{
		cell.menuItemTitle.text = @"Notes";
        cell.menuItemImage.image=[UIImage imageNamed:@"menuNotes"];
//        if (selectedIndex == row) {
//         //   thumbnail = [UIImage imageNamed:@"mynotes-lp-icon_active.png"];
//           // cell.textLabel.textColor = [UIColor sidePanelActiveColor];
//
//        }
//        else{
//      // thumbnail = [UIImage imageNamed:@"mynotes-lp-icon.png"];
//            
//        }
//        
//      //  cell.menuItemImage=[UIImage imageNamed:@"welcome_icon_active.png"];

	}
    else if (row == 4)
	{
		cell.menuItemTitle.text= @"Polling";
         cell.menuItemImage.image=[UIImage imageNamed:@"menuPolling"];
        if (selectedIndex == row) {
         //   thumbnail = [UIImage imageNamed:@"polls-lp-icon_active.png"];
           // cell.textLabel.textColor = [UIColor navBarGreenColor];

        }
        else{
      ///  thumbnail =  [UIImage imageNamed:@"polls-lp-icon.png"];
        }
        
        
      //  cell.menuItemImage=[UIImage imageNamed:@"welcome_icon_active.png"];

	}
//    if (row !=0) {
//        CGSize itemSize = CGSizeMake(22.5, 22.5);
//        UIGraphicsBeginImageContext(itemSize);
//        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//        [thumbnail drawInRect:imageRect];
//        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//
//    }
    cell.backgroundColor = [UIColor clearColor];
 //   cell.textLabel.textColor = [UIColor whiteColor];
 //   cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    
    //cell.selectionStyle = uitableviewsel;
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:43.0/255.0 blue:40.0/255.0 alpha:1.0];
    [cell setSelectedBackgroundView:bgColorView];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController *revealController = self.revealViewController;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *frontViewController = nil;
    BOOL isDuplicate = NO;
    switch (indexPath.row+1) {
        case 1:{
            if([revealController.frontViewController isKindOfClass:[WelcomeViewController class]])
            {
                isDuplicate = YES;
                break;
            }
            
            WelcomeViewController *controller = [[WelcomeViewController alloc] init];
            frontViewController = controller;
        }
            break;
     
        default:
            break;
    }
    if(!isDuplicate)
    {
        [revealController setFrontViewController:frontViewController animated:YES];
    }
    else{
        [revealController revealToggleAnimated:YES];
    }
    selectedIndex = indexPath.row;
    [self.featureListTable reloadData];
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _featureListTable.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark alerts
-(void) showAlert : (NSString *)alertMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertMessage delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
