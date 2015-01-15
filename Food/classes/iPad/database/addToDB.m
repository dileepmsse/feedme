//
//  addToDB.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "addToDB.h"
#import "dbHandler.h"
#import "FoodDataController.h"
#import "ReviewsDataController.h"
#import "RestaurantDataController.h"

@implementation addToDB

static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

static const char *KAddDocuments = "insert into Documents (FileID,DocumentName,FeatureType,DocumentImage,DocumentURL,FileExtension,FileOwner,FileLink,MODIFIEDON,LinkID) values(?,?,?,?,?,?,?,?,?,?)";

static const char *KAddSessions = "insert into Session (SessionId,EventID,SessionTopic,SessionVenue,SessionStartTime,SessionEndTime,SessionDescription,SessionTypeID,MODIFIEDON,SpeakerID) values(?,?,?,?,?,?,?,?,?,?)";

static const char *KAddAttendees = "insert into Attendees (AttendeeID,CompanyID,AttendeeName,AttendeeContact,Email,AttendeeImage,EventID,AttendeeURL,AttendeeBiodata,AttendeeDepartMent,AttendeeDesignation,AttendeeFirstName,AttendeeLastName,MODIFIEDON,PrivilegeID) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

//static const char *KAddMarketPlace = "insert into MarketPlace (EventID,BoothID,MODIFIEDON) values(?,?,?)";

//static const char *KAddHelpCenter = "insert into HelpCenter (HelpCenterName,HelpCenterContact,MODIFIEDON,Email,Owner,Description,EventID) values(?,?,?,?,?,?,?)";
/*
+ (void) AddDocuments:(NSMutableArray*)array
{
    sqlite3_stmt* statementDocuments;
    
    
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KAddDocuments, -1, &statementDocuments, NULL) == SQLITE_OK )
    {
     
        for (int i = 0; i < [array count]; i++) {
            NSDictionary *adict = [array objectAtIndex:i];
            DocumentData *data = [[DocumentData alloc] init];
            data.dTitle = [adict objectForKey:@"DocumentName"];
            data.dFeatureType = [[adict objectForKey:@"FeatureType"] integerValue];
            if ([adict objectForKey:@"DocumentImage"]!=[NSNull null])
            {
                NSString *picString = [[NSString alloc] initWithUTF8String: [[adict objectForKey:@"DocumentImage"] UTF8String]];
                NSData* imagedata= [addToDB decodeBase64WithString:picString];
                data.dImage = [UIImage imageWithData:imagedata];
            }
            
            data.dFileID = [[adict objectForKey:@"FileID"] integerValue];
            data.dFileOwner = [adict objectForKey:@"FileOwner"];
            data.dDocUrl = [adict objectForKey:@"FileLink"];
            data.dImageUrl = [adict objectForKey:@"DocumentURL"];
            data.dFileExtension = [adict objectForKey:@"FileExtension"];
           
            data.dDateModified = [adict objectForKey:@"MODIFIEDON"];
            

            
            
            sqlite3_bind_int(statementDocuments, 1, data.dFileID);

            if (data.dTitle != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 2, [data.dTitle UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            }

            
            sqlite3_bind_int(statementDocuments, 3, data.dFeatureType);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
           
            NSData *imagedata= UIImageJPEGRepresentation(data.dImage,0.0);
            if (imagedata!=nil) {
                sqlite3_bind_blob(statementDocuments, 4, [imagedata bytes], [imagedata length], SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dDocUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 5, [data.dDocUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dFileExtension != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 6, [data.dFileExtension UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dFileOwner != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 7, [data.dFileOwner UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dDocUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 8, [data.dDocUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }

            if (data.dDateModified != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 9, [data.dDateModified UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }

            sqlite3_bind_int(statementDocuments, 10, data.dLinkID);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));

            
            
            sqlite3_step(statementDocuments);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
            sqlite3_reset(statementDocuments);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
          
        }
      

    }
}


+(void) AddSessions:(NSMutableArray*) array
{
    for (int i = 0; i < [array count]; i++) {

    sqlite3_stmt* statementSessions;

    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KAddSessions, -1, &statementSessions, NULL) == SQLITE_OK )
    {
        
            AgendaData *data = [[AgendaData alloc] init];
            NSDictionary *adict = [array objectAtIndex:i];
            
            
            
            data.eTopic = [adict objectForKey:@"SessionTopic"];
            data.eLocation = [adict objectForKey:@"SessionVenue"];
            
            data.eStartDate = [adict objectForKey:@"SessionStartTime"];
            data.eEndDate = [adict objectForKey:@"SessionEndTime"];
            data.eDescription = [adict objectForKey:@"SessionDescription"];
            data.eSessionType = [[adict objectForKey:@"SessionTypeID"] integerValue];
            data.eLastModifiedDate = [adict objectForKey:@"MODIFIEDON"];
            data.eSpeakerID = [[adict objectForKey:@"SpeakerID"] integerValue];
            data.eID = [[adict objectForKey:@"EventID"] integerValue];
            data.eSessionID = [[adict objectForKey:@"SessionId"] integerValue];

            sqlite3_bind_int(statementSessions, 1, data.eSessionID);

            
            sqlite3_bind_int(statementSessions, 2, data.eID);

            if (data.eTopic != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 3, [data.eTopic UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            
            if (data.eLocation != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 4, [data.eLocation UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eStartDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 5, [data.eStartDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eEndDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 6, [data.eEndDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eDescription != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 7, [data.eDescription UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementSessions, 8, data.eSessionType);

            if (data.eLastModifiedDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, 9, [data.eLastModifiedDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }

        
            sqlite3_bind_int(statementSessions, 10, data.eSpeakerID);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
            sqlite3_step(statementSessions);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
            sqlite3_reset(statementSessions);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));

        }
     
    }

}

+(void) AddAttendees:(NSMutableArray*) array
{
    sqlite3_stmt* statementAttendees;
    
    
    
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KAddAttendees, -1, &statementAttendees, NULL) == SQLITE_OK )
    {
        for (int i = 0; i < [array count]; i++) {
            
            PersonData *data = [[PersonData alloc] init];
            NSDictionary *adict = [array objectAtIndex:i];
            
            
            data.pName = [adict objectForKey:@"AttendeeName"];
            data.pMobileTel = [adict objectForKey:@"AttendeeContact"];
            
            data.pEmailID = [adict objectForKey:@"Email"];
            
            if ([adict objectForKey:@"AttendeeImage"]!=[NSNull null])
            {
                NSString *picString = [[NSString alloc] initWithUTF8String: [[adict objectForKey:@"AttendeeImage"] UTF8String]];
                NSData* imagedata= [addToDB decodeBase64WithString:picString];
                data.pImage = [UIImage imageWithData:imagedata];
            }

            
            data.pImageUrl = [adict objectForKey:@"AttendeeURL"];
            data.pBiography = [adict objectForKey:@"AttendeeBiodata"];
            data.pDepartment = [adict objectForKey:@"AttendeeDepartMent"];
            data.pLastModified = [adict objectForKey:@"MODIFIEDON"];
            data.pEventID = [[adict objectForKey:@"EventID"] integerValue];
            data.pCompanyID = [[adict objectForKey:@"CompanyID"] integerValue];
            data.pid = [[adict objectForKey:@"AttendeeID"] integerValue];
            
            data.pJobTitle = [adict objectForKey:@"AttendeeDesignation"];
            data.pFirstName = [adict objectForKey:@"AttendeeFirstName"];
            data.pLastName = [adict objectForKey:@"AttendeeLastName"];
            data.pPrevilegeID = [[adict objectForKey:@"PrevilegeID"] integerValue];
            
            
            sqlite3_bind_int(statementAttendees, 1, data.pid);

            sqlite3_bind_int(statementAttendees, 2, data.pCompanyID);

            
            if (data.pName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 3, [data.pName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            }
            
            if (data.pContactAddress != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 4, [data.pContactAddress UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pEmailID != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 5, [data.pEmailID UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            NSData *imagedata= UIImageJPEGRepresentation(data.pImage,0.0);
            if (imagedata!=nil) {
                sqlite3_bind_blob(statementAttendees, 6, [imagedata bytes], [imagedata length], SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementAttendees, 7, data.pEventID);

            if (data.pImageUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 8, [data.pImageUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }

            
            if (data.pBiography != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 9, [data.pBiography UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pDepartment != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 10, [data.pDepartment UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            if (data.pJobTitle != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 11, [data.pJobTitle UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pFirstName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 12, [data.pFirstName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }

            
            if (data.pLastName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 13, [data.pLastName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pLastModified != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 14, [data.pLastModified UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementAttendees, 15, data.pPrevilegeID);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            

        }
        sqlite3_step(statementAttendees);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        sqlite3_reset(statementAttendees);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
    }
    NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));

}





+(void) AddBooths:(NSMutableArray*) array
{

}
+(void) AddHelpCenter:(NSMutableArray*) array
{

}

+ (NSData *)decodeBase64WithString:(NSString*)strBase64
{
    const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    int intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char * objResult;
    objResult = calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
    free(objResult);
    return objData;
}
*/

@end
