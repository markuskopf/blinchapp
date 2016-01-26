//
//  BLIRegistrationProcessingViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import "BLIRegistrationProcessingViewController.h"

@interface BLIRegistrationProcessingViewController ()

@end

@implementation BLIRegistrationProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerWithFirstName:nil lastName:nil email:nil];
}


- (void)registerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    
    NSString *blinchURL = @"http://localhost:8080/api/v1/customers/Kopf";
    NSMutableURLRequest *customersRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:blinchURL]];
    customersRequest.HTTPMethod = @"GET";
    
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:customersRequest
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         
                                                         NSError *jsonError = nil;
                                                         
                                                         id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                                                         
                                                         if (error!=nil) {
                                                             NSLog(@"Error desc: %@", error.description);
                                                             
                                                         } else {
                                                             // success forwards to landing view controller
                                                             NSLog(@"Return data: %@", returnValue);
                                                         }
                                                         
                                                     }];
    
    
    [dataTask resume];


}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
