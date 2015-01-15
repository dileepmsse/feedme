//
//  DataFromServer.h
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestResponse.h"

@protocol DataFromServer<NSObject>
@required
- (void) updateFinished;
- (void) cancelRefresh;
@optional
- (void) finishedwithError;
@end

@interface DataFromServer : NSObject
{
    RequestResponse *deltaRequest;
    UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic,strong) id <DataFromServer> delegate;
- (id) initWithDelegate:(id)aDelegate;
- (void) getDeltaDataForEvent:(int)eventID;
@end
