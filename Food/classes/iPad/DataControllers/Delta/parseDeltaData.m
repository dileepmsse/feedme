    //
//  parseDeltaData.m
//  ConfApp
//
//  Created by Dileep Mettu on 7/14/2014.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "parseDeltaData.h"
#import "Enums.h"
#import "dbHandler.h"
#import "modifyDB.h"
#import "addToDB.h"

@implementation parseDeltaData


static const char *kGetPersonWithId = "select * from Attendees where AttendeeID=?";
static const char *kGetDocumentsWithId = "select * from Documents where FileID=?";
static const char *kGetBoothWithId = "select * from MarketPlace where BoothID=?";
static const char *KGetSessionWithID = "select * from Session where SessionId=?";
static const char *KGetHelpCenterWithID = "select * from HelpCenter where HelpCenterID=?";


+(BOOL) IsIdExists:(int) idToCheck type:(int)valuetype
{
    sqlite3_stmt *statement = NULL;
    
    BOOL exists = FALSE;
    
    switch (valuetype) {
        case EAttendees:
        {
            if( sqlite3_prepare_v2([dbHandler sharedDatabase], kGetPersonWithId, -1, &statement, NULL) == SQLITE_OK )
            {
                sqlite3_bind_int(statement, 1, idToCheck);
                if(sqlite3_step(statement) == SQLITE_ROW)
                {
                    exists =  true;
                    break;
                }
            }
        }
            break;
            
        case EDocuments:
        {
            {
                if( sqlite3_prepare_v2([dbHandler sharedDatabase], kGetDocumentsWithId, -1, &statement, NULL) == SQLITE_OK )
                {
                    sqlite3_bind_int(statement, 1, idToCheck);
                    if(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        exists =  true;
                        break;
                    }
                }
            }
            break;
            
        }
            
        case EMarketPlace:
        {
            {
                if( sqlite3_prepare_v2([dbHandler sharedDatabase], kGetBoothWithId, -1, &statement, NULL) == SQLITE_OK )
                {
                    sqlite3_bind_int(statement, 1, idToCheck);
                    if(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        exists =  true;
                        break;
                    }
                }
            }
            break;
            
        }
            
        case EAgenda:
        {
            {
                if( sqlite3_prepare_v2([dbHandler sharedDatabase], KGetSessionWithID, -1, &statement, NULL) == SQLITE_OK )
                {
                    sqlite3_bind_int(statement, 1, idToCheck);
                    if(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        exists =  true;
                        break;
                    }
                }
            }
            break;
            
        }
            
        case EHelpCenter:
        {
            {
                if( sqlite3_prepare_v2([dbHandler sharedDatabase], KGetHelpCenterWithID, -1, &statement, NULL) == SQLITE_OK )
                {
                    sqlite3_bind_int(statement, 1, idToCheck);
                    if(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        exists =  true;
                        break;
                    }
                }
            }
            break;
            
        }
            
      
        default:
            break;
    }
    sqlite3_reset(statement);
    return exists;
    
    
}

+(void) deltaData:(NSString *)resultstring
{
    SBJSON *jsonParser = [[SBJSON alloc] init];
    NSError *jsonError;
//    resultstring = @"{\"Attendees\":[{\"AttendeeID\":2,\"CompanyID\":1,\"AttendeeName\":\"Pallab Varshney\",\"AttendeeContact\":\"9867200001\",\"Email\":\"pallab.varshney@non.schneider-electric.com\",\"AttendeeImage\":null,\"EventID\":1,\"TOKEN\":\"qwerty\",\"AttendeeURL\":null,\"AttendeeBiodata\":null,\"AttendeeDepartMent\":\"Software Devp\",\"AttendeeDesignation\":\"Project Manager\",\"AttendeeFirstName\":\"Pallab Varshney\",\"AttendeeLastName\":\"y\",\"MODIFIEDON\":\"22-Apr-14 04:23:48\"}],\"Booth\":[],\"Documents\":[{\"FileID\":7,\"CreatedOn\":\"01-Jan-01 00:00:00\",\"FileOwner\":null,\"FileLink\":\"http://awswebservicesdev.schneider-electric.com/ConfAppApi/shared/ConfAppEvent.pdf\",\"FileExtension\":\"pdf\",\"FeatureType\":2,\"DocumentImage\":null,\"DocumentURL\":\"http://awswebservicesdev.schneider-electric.com/ConfAppApi/shared/ConfAppEvent.pdf\",\"EventID\":1,\"AttendeeID\":0,\"BoothID\":0,\"DocsByID\":0,\"SessionID\":0,\"MODIFIEDON\":\"26-May-14 07:45:15\",\"DocumentName\":\"Event Doc\"}],\"HelpCenter\":[],\"Session\":[{\"SessionId\":2,\"EventID\":1,\"SessionTopic\":\"Eventus dev1.0\",\"SessionVenue\":\"Rmz-nxt\",\"SessionStartTime\":\"24-Mar-14 08:00:00\",\"SessionEndTime\":\"24-Mar-14 09:30:00\",\"SessionDescription\":\"Development progress\",\"SessionTypeID\":4,\"MODIFIEDON\":\"22-Apr-14 04:23:48\",\"IsSQLiteExported\":false,\"SpeakerID\":8}],\"Deleted\":{\"Attendees\":[48,49,50],\"Booth\":[],\"Documents\":[],\"HelpCenter\":[],\"Session\":[]}}";
    
    NSDictionary *dictionaryJsonData = nil;
    dictionaryJsonData = [jsonParser objectWithString:resultstring error:&jsonError] ;
    
    NSMutableArray *documentsarray = [[NSMutableArray alloc] init];
    if ([dictionaryJsonData objectForKey:@"Documents"] != [NSNull null])
    {
        documentsarray = [dictionaryJsonData objectForKey:@"Documents"];
    }
    
    NSMutableArray *attendeesarray= [[NSMutableArray alloc] init];
    if ([dictionaryJsonData objectForKey:@"Attendees"] != [NSNull null])
    {
        attendeesarray = [dictionaryJsonData objectForKey:@"Attendees"];
    }
    NSMutableArray *marketplacearray= [[NSMutableArray alloc] init];
    if ([dictionaryJsonData objectForKey:@"Booth"] != [NSNull null])
    {
        marketplacearray = [dictionaryJsonData objectForKey:@"Booth"];
    }
    
    NSMutableArray *sessionsarray= [[NSMutableArray alloc] init];
    if ([dictionaryJsonData objectForKey:@"Session"] != [NSNull null])
    {
        sessionsarray = [dictionaryJsonData objectForKey:@"Session"];
    }
    NSMutableArray *helpcenterarray= [[NSMutableArray alloc] init];
    if ([dictionaryJsonData objectForKey:@"HelpCenter"] != [NSNull null])
    {
        helpcenterarray = [dictionaryJsonData objectForKey:@"HelpCenter"];
    }

    NSDictionary *deleted_dictionaryJsonData = nil;

    deleted_dictionaryJsonData = [dictionaryJsonData objectForKey:@"Deleted"];
    
    NSMutableArray *deleted_documentsarray = [[NSMutableArray alloc] init];
    if ([deleted_dictionaryJsonData objectForKey:@"Documents"] != [NSNull null])
    {
        deleted_documentsarray = [deleted_dictionaryJsonData objectForKey:@"documents"];
    }
    
    NSMutableArray *deleted_attendeesarray = [[NSMutableArray alloc] init];
    if ([deleted_dictionaryJsonData objectForKey:@"Attendees"] != [NSNull null])
    {
        deleted_attendeesarray = [deleted_dictionaryJsonData objectForKey:@"Attendees"];
    }
    NSMutableArray *deleted_marketplacearray = [[NSMutableArray alloc] init];
    if ([deleted_dictionaryJsonData objectForKey:@"Booth"] != [NSNull null])
    {
        deleted_marketplacearray = [deleted_dictionaryJsonData objectForKey:@"Booth"];
    }
    
    NSMutableArray *deleted_sessionsarray = [[NSMutableArray alloc] init];
    if ([deleted_dictionaryJsonData objectForKey:@"Session"] != [NSNull null])
    {
        deleted_sessionsarray = [deleted_dictionaryJsonData objectForKey:@"Session"];
    }
    NSMutableArray *deleted_helpcenterarray = [[NSMutableArray alloc] init];
    if ([deleted_dictionaryJsonData objectForKey:@"HelpCenter"] != [NSNull null])
    {
        deleted_helpcenterarray = [deleted_dictionaryJsonData objectForKey:@"HelpCenter"];
    }
    
    
    NSMutableArray *modified_documents = [[NSMutableArray alloc] init];
    NSMutableArray *modified_sessions = [[NSMutableArray alloc] init];
    NSMutableArray *modified_attendees = [[NSMutableArray alloc] init];
    NSMutableArray *modified_helpcenters = [[NSMutableArray alloc] init];
    NSMutableArray *modified_booth = [[NSMutableArray alloc] init];

    NSMutableArray *new_documents = [[NSMutableArray alloc] init];
    NSMutableArray *new_sessions = [[NSMutableArray alloc] init];
    NSMutableArray *new_attendees = [[NSMutableArray alloc] init];
    NSMutableArray *new_helpcenters = [[NSMutableArray alloc] init];
    NSMutableArray *new_booth = [[NSMutableArray alloc] init];
    
    
    if (documentsarray.count > 0) {
        for (int i=0; i<documentsarray.count; i++) {
            NSDictionary *dict = [documentsarray objectAtIndex:i];
            int idtocheck = [[dict objectForKey:@"FileID"] integerValue];
            BOOL isidexists = [parseDeltaData IsIdExists:idtocheck type:EDocuments];
            if (isidexists) {
                [modified_documents addObject:dict];
            }
            else{
                [new_documents addObject:dict];
            }
        }
    }
    
    if (attendeesarray.count > 0) {
        for (int i=0; i<attendeesarray.count; i++) {
            NSDictionary *dict = [attendeesarray objectAtIndex:i];
            int idtocheck = [[dict objectForKey:@"AttendeeID"] integerValue];
            BOOL isidexists = [parseDeltaData IsIdExists:idtocheck type:EAttendees];
            if (isidexists) {
                [modified_attendees addObject:dict];
            }
            else{
                [new_attendees addObject:dict];
            }

        }
    }

    if (marketplacearray.count > 0) {
        for (int i=0; i<marketplacearray.count; i++) {
            NSDictionary *dict = [marketplacearray objectAtIndex:i];
            int idtocheck = [[dict objectForKey:@"BoothID"] integerValue];
            BOOL isidexists = [parseDeltaData IsIdExists:idtocheck type:EMarketPlace];
            if (isidexists) {
                [modified_booth addObject:dict];
            }
            else{
                [new_booth addObject:dict];
            }

        }
    }

    if (helpcenterarray.count > 0) {
        for (int i=0; i<helpcenterarray.count; i++) {
            NSDictionary *dict = [helpcenterarray objectAtIndex:i];
            int idtocheck = [[dict objectForKey:@"HelpCenterID"] integerValue];
            BOOL isidexists = [parseDeltaData IsIdExists:idtocheck type:EHelpCenter];
            if (isidexists) {
                [modified_helpcenters addObject:dict];
            }
            else{
                [new_helpcenters addObject:dict];
            }

        }
    }
    if (sessionsarray.count > 0) {
        for (int i=0; i<sessionsarray.count; i++) {
            NSDictionary *dict = [sessionsarray objectAtIndex:i];
            int idtocheck = [[dict objectForKey:@"SessionId"] integerValue];
            BOOL isidexists = [parseDeltaData IsIdExists:idtocheck type:EAgenda];
            if (isidexists) {
                [modified_sessions addObject:dict];
            }
            else{
                [new_sessions addObject:dict];
            }

        }
    }

    
    //delete the records
    for (int i = 0; i < deleted_documentsarray.count; i++) {
        int idtodelete = [[deleted_documentsarray objectAtIndex:i] integerValue];
        [modifyDB DeleteDocuments:idtodelete];
    }
    for (int i = 0; i < deleted_attendeesarray.count; i++) {
        int idtodelete = [[deleted_attendeesarray objectAtIndex:i] integerValue];
        [modifyDB DeleteAttendee:idtodelete];
    }
    for (int i = 0; i < deleted_helpcenterarray.count; i++) {
        int idtodelete = [[deleted_helpcenterarray objectAtIndex:i] integerValue];
        [modifyDB DeleteHelpCenter:idtodelete];
    }
    for (int i = 0; i < deleted_marketplacearray.count; i++) {
        int idtodelete = [[deleted_marketplacearray objectAtIndex:i] integerValue];
        [modifyDB DeleteMarketPlace:idtodelete];
    }
    for (int i = 0; i < deleted_sessionsarray.count; i++) {
        int idtodelete = [[deleted_sessionsarray objectAtIndex:i] integerValue];
        [modifyDB DeleteSession:idtodelete];
    }
    
    
    
    //add the records
    
    if (new_documents.count > 0 ) {
        [addToDB AddDocuments:new_documents];
    }
    if (new_attendees.count > 0 ) {
        [addToDB AddAttendees:new_attendees];
    }
    if (new_helpcenters.count > 0 ) {
        [addToDB AddHelpCenter:new_helpcenters];
    }
    if (new_sessions.count > 0 ) {
        [addToDB AddSessions:new_sessions];
    }
    if (new_booth.count > 0 ) {
        [addToDB AddBooths:new_booth];
    }
  
    //modify records
    if (modified_documents.count > 0 ) {
        [modifyDB ModifyDocuments:modified_documents];
    }
    if (modified_attendees.count > 0 ) {
        [modifyDB ModifyAttendees:modified_attendees];
    }
    if (modified_helpcenters.count > 0 ) {
        [modifyDB ModifyHelpCenter:modified_helpcenters];
    }
    if (modified_sessions.count > 0 ) {
        [modifyDB ModifySessions:modified_sessions];
    }
    if (modified_booth.count > 0 ) {
        [modifyDB ModifyBooths:modified_booth];
    }

    
}


@end
