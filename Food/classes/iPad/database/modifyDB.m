//
//  modifyDB.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "modifyDB.h"
#import "dbHandler.h"
#import "FoodDataController.h"
#import "ReviewsDataController.h"
#import "RestaurantDataController.h"
#import "addToDB.h"

@implementation modifyDB

static const char *KDeleteSession = "delete from Session where SessionId=?";
static const char *KDeleteAttendee = "delete from Attendees where AttendeeID=?";
static const char *KDeleteDocument = "delete from Documents where FileID=?";
static const char *KDeleteHelpCenter = "delete from HelpCenter where HelpCenterID=?";
static const char *KDeleteBooth = "delete from MarketPlace where BoothID=?";

static const char *KModifyDocuments = "update Documents set DocumentName=?,FeatureType=?,DocumentImage=?,DocumentURL=?,FileExtension=?,FileOwner=?,FileLink=?,MODIFIEDON=?,LinkID=? where FileID=?";

static const char *KModifySessions = "update Session set EventID=?,SessionTopic=?,SessionVenue=?,SessionStartTime=?,SessionEndTime=?,SessionDescription=?,SessionTypeID=?,MODIFIEDON=?,SpeakerID=? where SessionID=?";

static const char *KModifyAttendees = "update Attendees set CompanyID=?,AttendeeName=?,AttendeeContact=?,Email=?,AttendeeImage=?,EventID=?,AttendeeURL=?,AttendeeBiodata=?,AttendeeDepartMent=?,AttendeeDesignation=?,AttendeeFirstName=?,AttendeeLastName=?,MODIFIEDON=?,PrivilegeID=? where AttendeeID=?";

static const char *KModifyMarketPlace = "update MarketPlace set EventID=?,BoothID=?,MODIFIEDON=?";

static const char *KModifyHelpCenter = "update HelpCenter set HelpCenterName=?,HelpCenterContact=?,MODIFIEDON=?,Email=?,Owner=?,Description=?,EventID=?";
/*
+ (void) DeleteAttendee:(int)attendeeid
{
    sqlite3_stmt* statementDeleteAttendee;
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KDeleteAttendee, -1, &statementDeleteAttendee, NULL) == SQLITE_OK )
    {
        sqlite3_bind_int(statementDeleteAttendee, 1, attendeeid);
        sqlite3_step(statementDeleteAttendee);
        sqlite3_reset(statementDeleteAttendee);
    }
    
}

+ (void) DeleteDocuments:(int)fileid
{
    sqlite3_stmt* statementDeleteDocument;
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KDeleteDocument, -1, &statementDeleteDocument, NULL) == SQLITE_OK )
    {
        sqlite3_bind_int(statementDeleteDocument, 1, fileid);
        sqlite3_step(statementDeleteDocument);
        sqlite3_reset(statementDeleteDocument);
    }
    
}

+ (void) DeleteSession:(int)sessionid
{
    sqlite3_stmt* statementDeleteSession;
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KDeleteSession, -1, &statementDeleteSession, NULL) == SQLITE_OK )
    {
        sqlite3_bind_int(statementDeleteSession, 1, sessionid);
        sqlite3_step(statementDeleteSession);
        sqlite3_reset(statementDeleteSession);
    }
    
}

+ (void) DeleteHelpCenter:(int)helpcenterid
{
    sqlite3_stmt* statementDeleteHelpCenter;
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KDeleteHelpCenter, -1, &statementDeleteHelpCenter, NULL) == SQLITE_OK )
    {
        sqlite3_bind_int(statementDeleteHelpCenter, 1, helpcenterid);
        sqlite3_step(statementDeleteHelpCenter);
        sqlite3_reset(statementDeleteHelpCenter);
    }
    
}

+ (void) DeleteMarketPlace:(int)boothid
{
    sqlite3_stmt* statementDeleteBooth;
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KDeleteBooth, -1, &statementDeleteBooth, NULL) == SQLITE_OK )
    {
        sqlite3_bind_int(statementDeleteBooth, 1, boothid);
        sqlite3_step(statementDeleteBooth);
        sqlite3_reset(statementDeleteBooth);
    }
    
}

+(void) ModifyDocuments:(NSMutableArray*) array
{
    for (int i = 0; i < [array count]; i++) {

    sqlite3_stmt* statementDocuments;
    
    
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KModifyDocuments, -1, &statementDocuments, NULL) == SQLITE_OK )
    {
        
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
            
            
            if (data.dTitle != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 1, [data.dTitle UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            }
            
            
            sqlite3_bind_int(statementDocuments, 2, data.dFeatureType);
            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
            NSData *imagedata= UIImageJPEGRepresentation(data.dImage,0.0);
            if (imagedata!=nil) {
                sqlite3_bind_blob(statementDocuments, 3, [imagedata bytes], [imagedata length], SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dDocUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 4, [data.dDocUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dFileExtension != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 5, [data.dFileExtension UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dFileOwner != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 6, [data.dFileOwner UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dDocUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 7, [data.dDocUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.dDateModified != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementDocuments, 8, [data.dDateModified UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            sqlite3_bind_int(statementDocuments, 9, data.dLinkID);
            sqlite3_bind_int(statementDocuments, 10, data.dFileID);

            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        sqlite3_step(statementDocuments);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        sqlite3_reset(statementDocuments);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        }
    }
}


+(void) ModifySessions:(NSMutableArray*) array
{
    for (int i = 0; i < 1; i++) {

    
    sqlite3_stmt* statementSessions;
    
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KModifySessions, -1, &statementSessions, NULL) == SQLITE_OK )
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
            
            
            int i = 0;
            
            sqlite3_bind_int(statementSessions, i+1, data.eID);
            
            if (data.eTopic != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+2, [data.eTopic UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            
            if (data.eLocation != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+3, [data.eLocation UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eStartDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+4, [data.eStartDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eEndDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+5, [data.eEndDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.eDescription != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+6, [data.eDescription UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementSessions, i+7, data.eSessionType);
            
            if (data.eLastModifiedDate != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementSessions, i+8, [data.eLastModifiedDate UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementSessions, i+9, data.eSpeakerID);
        
            sqlite3_bind_int(statementSessions, i+10, data.eSessionID);

            NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
        sqlite3_step(statementSessions);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        sqlite3_reset(statementSessions);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        }
    
    //    sqlite3_exec([dbHandler sharedDatabase], KModifySessions, NULL, NULL, NULL);

     //   statementSessions = nil;
    }
    

}

+(void) ModifyAttendees:(NSMutableArray*) array
{
    for (int i = 0; i < [array count]; i++) {

    sqlite3_stmt* statementAttendees;
    
    
    
    if( sqlite3_prepare_v2([dbHandler sharedDatabase], KModifyAttendees, -1, &statementAttendees, NULL) == SQLITE_OK )
    {
        
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
            data.pLastModified = [adict objectForKey:@"AttendeeLastName"];
            data.pPrevilegeID = [[adict objectForKey:@"PrevilegeID"] integerValue];
            
            
            int i = 0;
            sqlite3_bind_int(statementAttendees, i+1, data.pCompanyID);
            
            
            if (data.pName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+2, [data.pName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            }
            
            if (data.pContactAddress != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+3, [data.pContactAddress UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pEmailID != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+4, [data.pEmailID UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            NSData *imagedata= UIImageJPEGRepresentation(data.pImage,0.0);
            if (imagedata!=nil) {
                sqlite3_bind_blob(statementAttendees, i+5, [imagedata bytes], [imagedata length], SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            sqlite3_bind_int(statementAttendees, i+6, data.pEventID);
            
            if (data.pImageUrl != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, 7, [data.pImageUrl UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            if (data.pBiography != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+8, [data.pBiography UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pDepartment != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+9, [data.pDepartment UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            if (data.pJobTitle != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+10, [data.pJobTitle UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pFirstName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+11, [data.pFirstName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            if (data.pLastName != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+12, [data.pLastName UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            if (data.pLastModified != (NSString *)[NSNull null]) {
                sqlite3_bind_text(statementAttendees, i+13, [data.pLastModified UTF8String], -1, SQLITE_TRANSIENT);
                NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
                
            }
            
            
            sqlite3_bind_int(statementAttendees, i+14, data.pPrevilegeID);
        sqlite3_bind_int(statementAttendees, i+15, data.pid);

        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
            
        sqlite3_step(statementAttendees);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        
        sqlite3_reset(statementAttendees);
        NSLog(@"prepare failed: %s", sqlite3_errmsg([dbHandler sharedDatabase]));
        }
      
    }

}

+(void) ModifyBooths:(NSMutableArray*) array
{
    
}

+(void) ModifyHelpCenter:(NSMutableArray*) array
{
    
}


*/


@end
