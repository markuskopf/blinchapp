//
//  BLILandingViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "BLILandingViewController.h"
#import "BLIConstants.h"
#import "BLIRegistrationViewController.h"
#import "BLILoginViewController.h"

@interface BLILandingViewController ()

@property(nonatomic, copy) NSString *csrf_cookie;
@property(nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property(nonatomic, strong) NSMutableURLRequest *request;
@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) NSURL *url;

@end

@implementation BLILandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Basic implementation for CRSF call.
    
    
    _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    
    [_sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json",
                                               @"Authorization": @"Basic a29wZi5tYXJrdXNAYmxpbmNoYXBwLmNvbToxMjM0NTY3OA==",
                                               @"X-Requested-With": @"XMLHttpRequest"}];
    
    _sessionConfig.timeoutIntervalForRequest = 30.0;
    _sessionConfig.timeoutIntervalForResource = 60.0;
    _sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    _sessionConfig.HTTPShouldSetCookies = YES;
    
    
    
    _url =  [NSURL URLWithString:@"http://192.168.0.12:8080/api/v1/history"];
    NSString *authValue = @"Basic a29wZi5tYXJrdXNAYmxpbmNoYXBwLmNvbToxMjM0NTY3OA==";
    
    _request = [[NSMutableURLRequest alloc] initWithURL:self.url];
    [_request setHTTPMethod:@"GET"];
    [_request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [_request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    _session = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:BLIRegistrationSegue]) {
        
    } else if ([segue.identifier isEqualToString:BLILoginSegue]) {
        // handle data if necessary
    }
}

- (IBAction)registrationPressed:(id)sender {
    
    [self performSegueWithIdentifier:BLIRegistrationSegue sender:sender];
    
}

- (IBAction)loginPressed:(id)sender {
    
    [self performSegueWithIdentifier:BLILoginSegue sender:sender];
    
}


- (IBAction)testPressed:(id)sender {
    
//    NSArray *allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError = nil;
        
        id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"Return data: %@", returnValue);
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)response allHeaderFields] forURL:[NSURL URLWithString:@""]];
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:self.url mainDocumentURL:nil];
        // for some reason we need to re-store the CSRF token as X_CSRFTOKEN
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"XSRF-TOKEN"]) {
                self.csrf_cookie = cookie.value;
                break;
            }
        }
    }];
    
    
    [task resume];
}


@end
