//
//  RequestResponse.m
//  ConfApp
//
//  Created by Dileep Mettu on 4/16/14.
//
//
#import "RequestResponse.h"
#import "SBJSON.h"
#import <util.h>
#define kDefaultTimeOutValue 60.0


@implementation RequestResponse

@synthesize delegate;
@synthesize url;
@synthesize httpMethod;
@synthesize parameters;
@synthesize credential;

@synthesize contentType;
@synthesize serviceType;
@synthesize resultString;
@synthesize timeOutValue;
@synthesize httpBody;
@synthesize allHeaderFields;
@synthesize showConnectionMessage;



#pragma mark -
#pragma mark - Object Functions

- (id) initWithURL:(NSURL *)aUrl
		httpMethod:(RequestResponseHTTPMethod)aHttpMethod
		parameters:(id)aParameters
		credential:(NSURLCredential *)aCredential
		  delegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
        self.showConnectionMessage = TRUE;
		self.url = aUrl;
		self.httpMethod = aHttpMethod;
		if ([aParameters isKindOfClass:[NSString class]]) {
			self.httpBody = [aParameters dataUsingEncoding:NSUTF8StringEncoding];
		} else {
			self.parameters = (NSDictionary *)aParameters;
		}
		if (aCredential.user != nil) {
			self.credential = aCredential;
		}
		
		self.delegate = aDelegate;
		self.timeOutValue = [NSNumber numberWithDouble:kDefaultTimeOutValue];
	}
	return self;
}


#pragma mark -
#pragma mark NSURLConnection delegate

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] ||
			[protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault]);
}



- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if (self.credential == nil || [challenge previousFailureCount] >= 1) {
        [challenge.sender useCredential:[NSURLCredential  credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
		[[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
	} else {
		[[challenge sender] useCredential:self.credential forAuthenticationChallenge:challenge];
	}
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.allHeaderFields =[httpResponse allHeaderFields];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if (receivedData == nil) {
		receivedData = [[NSMutableData alloc] initWithData:data];
	} else {
		[receivedData appendData:data];
	}
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *stringData = [[NSString alloc] initWithBytes:[receivedData bytes]
													length:[receivedData length]
												  encoding: NSUTF8StringEncoding];
	self.resultString = stringData;
    
	if ([[self.allHeaderFields objectForKey:@"Content-Type"] isEqualToString:[RequestResponse convertRequestResponseContentTypeToString:RequestResponseContentTypeJSON]]) {
		// Json
		self.contentType = RequestResponseContentTypeJSON;
	}
    [delegate requestResponseDidRecieveData:stringData withService:serviceType];
    
    
	
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(delegate != nil && [delegate respondsToSelector:@selector(requestResponseDidfailedWithError:withService:)]) {
        [delegate requestResponseDidfailedWithError:error withService:serviceType];
    }
}


- (void) sendRequest:(RequestResponseContentType)contentType
{
	
	//NSJSONSerialization
	urlRequest = [[NSMutableURLRequest alloc] initWithURL:self.url];
	[urlRequest setHTTPMethod:[self getHTTPMethodString]];
	[urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[urlRequest setTimeoutInterval:[self.timeOutValue doubleValue]];
	
	switch (self.httpMethod) {
		case RequestResponseHTTPMethodGET:
		case RequestResponseHTTPMethodPOST:
        if( self.parameters==nil) {
            [urlRequest setHTTPBody:[[httpBody copy] dataUsingEncoding:NSUTF8StringEncoding]];
        } else {
            httpBody=[[self getParameterPostString] dataUsingEncoding:NSUTF8StringEncoding];
            [urlRequest setHTTPBody:httpBody];
        }
        //set header
            
        break;
	}
	[urlRequest setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];

    NSString *authStr = @"d0706aaa-163b-492c-9765-2e1037517203";
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [RequestResponse base64String:authStr]];
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];

    
    NSLog(@"%@",urlRequest) ;
    if([self CheckNetworkConnection])
    {
        urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        [urlConnection start];
    }
    else
    {
        if(self.showConnectionMessage)
        {
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"Info" message:@"There is no network connection or host is not reachable" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
        }
        if(delegate != nil && [delegate respondsToSelector:@selector(requestResponseDidfailedWithError:withService:)]) {
            [delegate requestResponseDidfailedWithError:nil withService:serviceType];
            [self cancelRequest];
        }
        
        
    }
}


- (NSString *)getParameterGetString
{
	if (!self.parameters) {
		return @"";
	}
	NSMutableString *getString = [[NSMutableString alloc] initWithString:@"?"];
	for (NSString *key in [self.parameters keyEnumerator]) {
		[getString appendFormat:@"%@=%@&", key, [self.parameters objectForKey:key]];
	}
    
	return getString ;
}

- (NSString *)getParameterPostString
{
    
    NSData* nsdata = [NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONReadingMutableContainers error:nil];
    
    NSString* jsonString =[[NSString alloc] initWithData:nsdata encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
    }

+ (NSString *)convertRequestResponseContentTypeToString:(RequestResponseContentType)contentType
{
	switch (contentType) {
		case RequestResponseContentTypeJSON:
		default:
        return @"plain/text";
	}
}

- (NSString *)getHTTPMethodString
{
	switch (self.httpMethod) {
		case RequestResponseHTTPMethodGET:
        return @"GET";
		case RequestResponseHTTPMethodPOST:
        return @"POST";
		default:
        return nil;
	}
}

-(void)cancelRequest
{
    [urlConnection cancel];
    self.delegate=nil;
}

-(NetworkStatus)CheckNetworkConnection
{
    
    internetReach = [Reachability reachabilityForInternetConnection];
    wifiReach = [Reachability reachabilityForLocalWiFi];
    
    NetworkStatus netStatus = ([wifiReach currentReachabilityStatus]||[internetReach currentReachabilityStatus]||[hostReach currentReachabilityStatus]);
    return netStatus;
	
    
}

+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end
