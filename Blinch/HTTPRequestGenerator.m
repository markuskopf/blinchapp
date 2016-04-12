//
//  HTTPRequestGenerator.m
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 blinch. All rights reserved.
//

#import "HTTPRequestGenerator.h"


@interface HTTPRequestGenerator ()

@property(nonatomic, readonly, copy) NSURL *endpointURL;


@end

@implementation HTTPRequestGenerator

- (instancetype)init {
    return [self initWithEndpointURL:nil];
}

- (instancetype)initWithEndpointURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _endpointURL = url;
    }
    
    return self;
}


#pragma mark - 

- (NSMutableURLRequest *)requestWithPath:(NSString *)path
                                  method:(NSString *)httpMethod
                              parameters:(NSDictionary *)params
                               authValue:(NSString *)authValue {
    
    NSURL *URL = [self.endpointURL URLByAppendingPathComponent:path];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [request setHTTPMethod:httpMethod];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    
    return request;
}

@end
