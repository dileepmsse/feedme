//
//  Enums.h
//

#import <Foundation/Foundation.h>
//#define srishti
#define jack
typedef enum {
    ENotAuthenticated = 1,
    EDownloadInProgress,
    EDownloadComplete,
    EReLogin
} eventStatus;

typedef enum {
    ECurrentEvent = 0,
    EPastEvent

} eventPeriod;

typedef enum {
    EText = 0,
    ESingleChoice,
    EMultipleChoice
} pollingQuestionType;

typedef enum {
    EWelcome = 1,
    EAgenda,
    EAttendees,
    EDocuments,
    EMarketPlace,
    EHelpCenter
} featureType;

typedef enum {
    EMessageStateDefault = 0,
    EMessageStateTypeMessage
    
} messageState;

