//
//  RequestResponse.h
//  Confapp
//
//  Created by Dileep Mettu on 7/13/2014.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


@class RequestResponse;

typedef enum {
	RequestResponseHTTPMethodGET,
	RequestResponseHTTPMethodPOST
} RequestResponseHTTPMethod;

typedef enum {
	RequestResponseContentTypeJSON,
	RequestResponseContentTypeXML
} RequestResponseContentType;

typedef enum {
    RequestResponseServiceTypeDefault,
    RequestResponseServiceTypeLogin,
    RequestResponseServiceTypeEventList,
    RequestResponseServiceTypeGetPollsBySession,
    RequestResponseServiceTypeActivePoll,
    RequestResponseServiceTypeSubmitPoll,
    RequestResponseServiceTypeGetPollResult,
    RequestResponseServiceTypeGetDelta,
    RequestResponseServiceTypeRegisterToken,
    RequestResponseServiceTypeDeRegisterToken,
    RequestResponseServiceTypePullBroadcastMessages,
    RequestResponseServiceTypePullInAppChatMessages,
    RequestResponseServiceTypeSendInAppChatMessage,
    RequestResponseServiceTypeDeleteInAppChatMessages

}RequestResponseServiceType;


@protocol RequestResponse<NSObject>
@required
- (void) requestResponseDidRecieveData:(NSString *) resultString withService:(RequestResponseServiceType)serviceType;
@optional
- (void) requestResponseDidfailedWithError:(NSError *)error withService:(RequestResponseServiceType)serviceType;


@end

@interface RequestResponse :NSObject<NSURLConnectionDelegate> {
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    
@private
	NSURLConnection *urlConnection;
	NSMutableURLRequest *urlRequest;
	NSMutableData *receivedData;
}


- (id) initWithURL:(NSURL *)aUrl httpMethod:(RequestResponseHTTPMethod)aHttpMethod parameters:(id)aParameters credential:(NSURLCredential *)aCredential delegate:(id)aDelegate;
- (NSString *)getHTTPMethodString;
- (NSString *)getParameterGetString;
- (NSString *)getParameterPostString;
- (void) sendRequest:(RequestResponseContentType)contentType;
+ (NSString *)convertRequestResponseContentTypeToString:(RequestResponseContentType)contentType;

-(void)cancelRequest;
-(NetworkStatus)CheckNetworkConnection;
@property (nonatomic, assign) BOOL showConnectionMessage;
@property (nonatomic,strong) id <RequestResponse> delegate;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,assign) RequestResponseHTTPMethod httpMethod;
@property (nonatomic,strong) NSDictionary *parameters;
@property (nonatomic,strong) NSURLCredential *credential;
@property (nonatomic,assign) RequestResponseContentType contentType;
@property (nonatomic,assign) RequestResponseServiceType serviceType;
@property (nonatomic,strong) NSString *resultString;
@property (nonatomic,strong) NSNumber *timeOutValue;
@property (nonatomic,strong) NSData *httpBody;
@property (nonatomic,strong) NSDictionary *allHeaderFields;



@end
