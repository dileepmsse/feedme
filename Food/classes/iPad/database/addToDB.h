//
//  addToDB.h
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addToDB : NSObject


+(void) AddDocuments:(NSMutableArray*) array;
+(void) AddBooths:(NSMutableArray*) array;
+(void) AddAttendees:(NSMutableArray*) array;
+(void) AddHelpCenter:(NSMutableArray*) array;
+(void) AddSessions:(NSMutableArray*) array;
+ (NSData *)decodeBase64WithString:(NSString*)strBase64;
@end
