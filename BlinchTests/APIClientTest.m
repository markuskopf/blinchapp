//
//  APIClientTest.m
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIClient.h"

@interface APIClientTest : XCTestCase

@property (nonatomic) NSOperationQueue *queue;
@property (nonatomic) APIClient *apiClient;

@end

@implementation APIClientTest

- (void)setUp {
    [super setUp];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 1;
    self.apiClient = [[APIClient alloc] initWithQueue:self.queue];
    
}

- (void)tearDown {
    self.apiClient = nil;
    self.queue = nil;
    
    [super tearDown];
}

- (void)testAPIClientInitialization {
    APIClient *apiClient = [[APIClient alloc] initWithQueue:[NSOperationQueue new]];
    
    
    XCTAssertNotNil(apiClient, @"APIClient is nil.....");
    XCTAssertTrue(apiClient!=nil);
}

- (void)testHistoryEndpoint {
    XCTestExpectation *expectation = [self expectationWithDescription:@"history endpoint"];
    
    [_apiClient loginWithUserName:@"kopf.markus@blinchapp.com"
                         password:@"12345678"
                completionHandler:^(NSDictionary *response, NSError *error) {
                    XCTAssertNil(error, @"Error during login...");
                    if (response != nil) {
                        [expectation fulfill];
                    }
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

- (void)testWrongCredentials {
    XCTestExpectation *expectation = [self expectationWithDescription:@"history endpoint"];
    
    [_apiClient loginWithUserName:@"kopf.markus@blinchapp.com"
                         password:@"123456789"
                completionHandler:^(NSDictionary *response, NSError *error) {
                    XCTAssertTrue(error.code == 401);
                    if (error.code == 401) {
                        [expectation fulfill];
                    }
                }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

@end
