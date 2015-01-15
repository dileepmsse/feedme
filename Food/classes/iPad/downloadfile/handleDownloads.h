//
//  handleDownloads.h
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "DownloadUrlToDiskOperation.h"
#import "RequestResponse.h"
#import "downloadAttributes.h"



@interface handleDownloads : NSObject
{
    NSMutableDictionary *downloadDictionary;
    NSOperationQueue *operationQueue;
    NSOperation *downloadToDiskOperation; // strong
    RequestResponse *webServiceRequest;
}


-(void) startDownloadOperations:(NSMutableArray*) downloadArray;
- (NSString*) getFilePath:(downloadAttributes*)attributes;
-(void) SetDownloadPriorityforDocid:(NSNotification*) notification;

@end
