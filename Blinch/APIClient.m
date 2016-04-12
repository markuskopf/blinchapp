//
//  APIClient.m
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "APIClient.h"
#import "HTTPRequestGenerator.h"

/**
 * Development host.
 */
static NSString * const DevHost = @"http://192.168.0.12:8080/";

/**
 * Endpoint path for history resource.
 */
static NSString * const APIClientEndpointHistory = @"api/v1/history";



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
        completionHandler:(void (^)(NSDictionary *response, NSDictionary *meta, NSError *error))completionHandler {
    
    if (completionHandler == nil) {
        assert(completionHandler);
    }
    
    
    NSString *authValue = @"Basic a29wZi5tYXJrdXNAYmxpbmNoYXBwLmNvbToxMjM0NTY3OA==";
    NSMutableURLRequest *request = [self.httpRequestGenerator requestWithPath:APIClientEndpointHistory
                                                                       method:@"GET"
                                                                   parameters:nil
                                                                    authValue:authValue];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         
                                                         NSError *jsonError = nil;
                                                         id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                                                         
                                                         if (error != nil) {
                                                             completionHandler(returnValue, nil, error);
                                                         } else {
                                                             completionHandler(returnValue, nil, error);
                                                         }
    }];
    
    [dataTask resume];
}


@end
