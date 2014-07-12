//
//  handleDownloads.m
//  ConfApp
//
//  Created by Dileep Mettu on 4/15/14.
//
//

#import "handleDownloads.h"

@implementation handleDownloads




-(void) startDownloadOperations:(NSMutableArray*) downloadArray
{
    downloadDictionary = [[NSMutableDictionary alloc] init];

    if (operationQueue == nil) {
        operationQueue = [NSOperationQueue new];
    }
    [operationQueue setMaxConcurrentOperationCount:2];
    
    
    for (downloadAttributes * attributes in downloadArray)
    {
        DownloadUrlToDiskOperation *operation;
        
        if (attributes.docID == nil) {
            NSString *filePath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
            
            NSError *error;
            
            NSString *filename = [attributes.eventID stringByAppendingString:@".zip"];
            filePath = [filePath stringByAppendingPathComponent:attributes.eventID];
                if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
                    [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder

            filePath = [filePath stringByAppendingPathComponent:filename];
            [downloadDictionary setValue:attributes.eventID forKey:attributes.eventID];
            operation = [[DownloadUrlToDiskOperation alloc] initWithUrl:[NSURL URLWithString:attributes.url] saveToFilePath:filePath];
        }
        else
        {
            operation = [[DownloadUrlToDiskOperation alloc] initWithUrl:[NSURL URLWithString:attributes.url] saveToFilePath:[self getFilePath:attributes]];
            [downloadDictionary setValue:[self getFilePath:attributes] forKey:attributes.eventID];

        }

        
        [operation setQueuePriority:NSOperationQueuePriorityVeryLow];
        [operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:NULL];
        [operationQueue addOperation:operation];
   
    }
    
}


- (NSString*) getFilePath:(downloadAttributes*)attributes
{
    NSString *filePath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];;

    NSError *error;
    
    if (attributes.eventID != nil) {
        filePath = [filePath stringByAppendingPathComponent:attributes.eventID];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
        
        if (attributes.featureName != nil) {
            filePath = [filePath stringByAppendingPathComponent:attributes.featureName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            
            if (attributes.featureKeyword != nil) {
                filePath = [filePath stringByAppendingPathComponent:attributes.featureName];
                if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
                [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            }
            filePath = [filePath stringByAppendingPathComponent:attributes.docID];
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
            
        }
        
    }
    NSString* filename = [attributes.url lastPathComponent];
    filePath = [filePath stringByAppendingPathComponent:filename];
   
    return filePath;
}

-(void) setEventStatus:(int)eventid status:(int)status
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    for(int i=0;i < array.count;i++){
        NSDictionary *dict = [array objectAtIndex:i];
        int dict_eventid = [[dict objectForKey:@"EventId"] intValue];
        if (eventid == dict_eventid) {
            [dict setValue:[NSNumber numberWithInt:status] forKey:@"eventstatus"];
            break;
        }
        
    }
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)operation change:(NSDictionary *)change context:(void *)context {
    NSString *source = nil;
    NSData *data = nil;
    NSError *error = nil;
    
    
    DownloadUrlToDiskOperation *downloadOperation = (DownloadUrlToDiskOperation *)operation;

    
    for (NSString *key in [downloadDictionary allKeys]) {
        NSLog(@"%@",[[downloadOperation.filePath lastPathComponent] stringByDeletingPathExtension]);
        if ([[downloadDictionary valueForKey:key] isEqualToString:[[downloadOperation.filePath lastPathComponent] stringByDeletingPathExtension]]) {
            source = key;
            break;
        }
    }
    if (source) {
        data = [NSData dataWithContentsOfFile:downloadOperation.filePath];
        error = [downloadOperation error];
        NSLog(@"error - %@",error.localizedDescription);
    }
    
    if (source) {
        NSLog(@"Downloaded finished from %@", source);
        if (error != nil) {
            // handle error
            // Notify that we have got an error downloading this data;
            [self setEventStatus:[source integerValue] status:ENotAuthenticated];
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.isDownloadInProgress = FALSE;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataDownloadFailed"
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:source, @"source", error, @"error", nil]];
            
        } else {
            // Notify that we have got this source data;
            [self setEventStatus:[source integerValue] status:EDownloadComplete];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            int eid = [source integerValue];
            [ud setInteger:eid forKey:@"eventid"];
            [ud synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataDownloadFinished"
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:source, @"source", data, @"data",@"no", @"error", nil]];
            // save data
            
        }
        
    }
}





-(void) SetDownloadPriorityforDocid:(NSNotification*) notification
{
    NSString *str = (NSString*)[notification object];
    for (int i=0; i<[[operationQueue operations] count]; i++) {
        NSString *filepath = [[[operationQueue operations] objectAtIndex:i] filePath];
        if ([str isEqualToString:filepath]) {
            [[[operationQueue operations] objectAtIndex:i] setQueuePriority:NSOperationQueuePriorityVeryHigh];
        }
    }
}

@end
