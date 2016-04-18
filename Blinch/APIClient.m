//
//  APIClient.m
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "APIClient.h"
#import "HTTPRequestGenerator.h"
#import "BlinchErrors.h"

/**
 * Development host.
 */
static NSString * const DevHost = @"http://192.168.0.12:8080/";

/**
 * Endpoint path for history resource.
 */
static NSString * const APIClientEndpointHistory = @"user";



@interface APIClient ()

@property(nonatomic, strong, readonly) NSURLSessionConfiguration *sessionConfig;

@property(nonatomic, strong, readonly) NSURLSession *session;

@property(nonatomic, strong, readonly) HTTPRequestGenerator *httpRequestGenerator;


@end


@implementation APIClient

- (instancetype)init {
    return [self initWithQueue:[NSOperationQueue new]];
}

- (instancetype)initWithQueue:(NSOperationQueue *)queue {
    self = [super init];
    if (self) {
        _queue = queue;
        assert(_queue != nil);
        
        _sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        [_sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json",
                                                   @"X-Requested-With": @"XMLHttpRequest"}];
        _sessionConfig.timeoutIntervalForRequest = 30.0;
        _sessionConfig.timeoutIntervalForResource = 60.0;
        _sessionConfig.HTTPMaximumConnectionsPerHost = 1;
        _sessionConfig.HTTPShouldSetCookies = YES;
        
        _session = [NSURLSession sessionWithConfiguration:_sessionConfig
                                                 delegate:nil
                                            delegateQueue:_queue];
        
        _httpRequestGenerator = [[HTTPRequestGenerator alloc] initWithEndpointURL:[NSURL URLWithString:DevHost]];
    }
    
    return self;
}

- (void)loginWithUserName:(NSString *)name
                 password:(NSString *)password
        completionHandler:(LoginCompletionHandler)completionHandler {
    
    if (completionHandler == nil) {
        assert(completionHandler);
    }
    
    NSString *base64AuthValue = [self createBasicAuthValueBase64EncodedWith:password name:name];
    
    NSMutableURLRequest *request = [self.httpRequestGenerator requestWithPath:APIClientEndpointHistory
                                                                       method:@"GET"
                                                                   parameters:nil
                                                                    authValue:base64AuthValue];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         
                                                         NSInteger httpStatus = [self httpStatusCode:response];
                                                         NSLog(@"Body: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                       
                                                         if (error != nil) {
                                                             NSLog(@"Error sending API description: %@", error);
                                                             
                                                             NSDictionary *responseDict = nil;
                                                             NSError *JSONError;
                                                             responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                            options:0
                                                                                                              error:&JSONError];
                                                            
                                                             if (responseDict == nil) {
                                                                 NSLog(@"Error creating dictionary from JSON data: %@", JSONError);
                                                             }
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 completionHandler(responseDict, error);
                                                             });
                                                         } else {
                                                             NSDictionary *responseDict = nil;
                                                             NSError *JSONError = nil;
                                                             responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                            options:NSJSONReadingMutableContainers
                                                                                                              error:&JSONError];
                                                             NSError *customError;
                                                             if (httpStatus != 200) {
                                                                customError = ErrorWithCode(httpStatus, error);
                                                             }
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 completionHandler(responseDict, customError);
                                                             });
                                                         }
                                                  
    }];
    
    [dataTask resume];
}

- (NSString *)createBasicAuthValueBase64EncodedWith:(NSString *)password name:(NSString *)name
{
    NSString *plainTextAuthValue = [NSString stringWithFormat:@"%@:%@", name, password];
    NSData *plainData = [plainTextAuthValue dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:1];
    NSString *base64AuthValue = [NSString stringWithFormat:@"Basic %@", base64String];
    return base64AuthValue;
}

- (NSInteger)httpStatusCode:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary* responseHeaders = httpResponse.allHeaderFields;
    NSLog(@"all response header fields: %@",responseHeaders);
    NSInteger httpStatus = httpResponse.statusCode;
    NSLog(@"HTTPStatusCode: %tu", httpStatus);
    
    return httpStatus;
}

@end
