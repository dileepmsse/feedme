//
//  dbHandler.h
//  ConfApp
//
//  Created by Dileep Mettu on 7/13/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface dbHandler : NSObject

+ (sqlite3 *)sharedDatabase;
+ (void) deleteEditableCopy:(NSString*)filepath;
+ (void) copyplist;
+ (void)setDataBaseToNil;

@end
