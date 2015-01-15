//
//  modifyDB.h
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface modifyDB : NSObject


+ (void) DeleteAttendee:(int)attendeeid;
+ (void) DeleteDocuments:(int)fileid;
+ (void) DeleteSession:(int)sessionid;
+ (void) DeleteHelpCenter:(int)helpcenterid;
+ (void) DeleteMarketPlace:(int)boothid;

+(void) ModifyDocuments:(NSMutableArray*) array;
+(void) ModifyBooths:(NSMutableArray*) array;
+(void) ModifyAttendees:(NSMutableArray*) array;
+(void) ModifyHelpCenter:(NSMutableArray*) array;
+(void) ModifySessions:(NSMutableArray*) array;
@end
