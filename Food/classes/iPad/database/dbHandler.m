//
//  dbHandler.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/13/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "dbHandler.h"

@implementation dbHandler

static sqlite3 *_sharedDatabase = nil;

+ (sqlite3 *)sharedDatabase
{
    
    if (_sharedDatabase != nil) {
        return _sharedDatabase;
    }
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);


    
    
    NSInteger eventid = [[NSUserDefaults standardUserDefaults] integerForKey:@"eventid"];
    NSString *filename = @"";

    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d", eventid]];
    
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:documentsDirectory error:nil];

    for (int i = 0; i < dirContents.count; i++) {
        NSString *name  = [dirContents objectAtIndex:i];
        if (![name isEqualToString:@".DS_Store"]) {
            filename = name;
            break;
        }
        
    }
    
    NSString *_writableDBPath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:_writableDBPath];
    
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:_writableDBPath error:nil];
    }
    
    int ret = sqlite3_open([_writableDBPath UTF8String], &_sharedDatabase);
    NSAssert1(ret == SQLITE_OK, @"Could not open database. '%s'", sqlite3_errmsg(_sharedDatabase));
    return _sharedDatabase;
}

+ (void) deleteEditableCopy:(NSString*)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:filepath];
    NSError *error;
    if(success)
    {
        [fileManager removeItemAtPath:filepath error:&error];
    }
}

+ (void) copyplist
{
    NSLog(@"Entered dbhandler copyplist: To check events plist is available or not");
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = @"events.plist";
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *_writableDBPath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:_writableDBPath];
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:_writableDBPath error:nil];
        NSMutableArray *plist = [[NSMutableArray alloc] init];
        [NSKeyedArchiver archiveRootObject:plist toFile:_writableDBPath];
            NSLog(@"Entered dbhandler copyplist: copied events plist");
    }
        NSLog(@"Ended dbhandler copyplist: To check events plist is available or not");
}

+ (void)setDataBaseToNil
{
    _sharedDatabase = nil;
}

@end
