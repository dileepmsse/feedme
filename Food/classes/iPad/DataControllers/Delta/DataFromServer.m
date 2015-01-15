//
//  DataFromServer.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "DataFromServer.h"
#import "commondefinitions.h"
#import "parseDeltaData.h"
#import "AppDelegate.h"
#import "RestaurantDataController.h"

@implementation DataFromServer


- (id) initWithDelegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
      		self.delegate = aDelegate;
	
	}
	return self;
}


- (void) getDeltaDataForEvent:(int)eventID
{

    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *date = @"02-23-2014 01:00 PM";
    date = [RestaurantDataController getLastModifiedDate];
    NSString *formurl = @"";
    if (date!=nil) {
        formurl = [NSString stringWithFormat:@"%@/%@/%d/%@%@",kFetchDeltaDataURL,appDelegate.userToken,eventID, @"?_date=",date];
    }
    else{
        formurl = kFetchEventsURL;
    }
    formurl = [formurl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:formurl];
    
    deltaRequest =[[RequestResponse alloc]initWithURL:url httpMethod:RequestResponseHTTPMethodGET parameters:nil credential:nil delegate:self];
    [deltaRequest sendRequest:RequestResponseContentTypeJSON];
    deltaRequest.serviceType=RequestResponseServiceTypeGetDelta;

}


-(void) requestResponseDidfailedWithError:(NSString*)error withService:(RequestResponseServiceType)serviceType
{
    [self.delegate cancelRefresh];
    NSLog(@"result string = %@",error);
     UIAlertView *view =  [[UIAlertView alloc]initWithTitle:@"Network error" message:@"Pls check network connection and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [view show];
    
}
- (void) requestResponseDidRecieveData:(NSString *) resultString withService:(RequestResponseServiceType)serviceType
{
    NSLog(@"result string = %@",resultString);
    
    
    switch (serviceType) {
        case RequestResponseServiceTypeGetDelta:{
            [parseDeltaData deltaData:resultString];
            [self.delegate updateFinished];
            }
            break;
        default:
            break;
    }
    
    
}





@end
