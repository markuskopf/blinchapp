//
//  BLIRegistrationProcessingViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import "BLIRegistrationProcessingViewController.h"

@interface BLIRegistrationProcessingViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *processingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *registeringLabel;

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
    
    [self.processingIndicator startAnimating];
    [self.navigationItem setHidesBackButton:YES animated:YES];

    [self registerWithFirstName:self.firstName lastName:self.lastName email:self.email];
}


- (void)registerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    
    NSString *blinchURL = @"http://localhost:8080/api/v1/customers";
    NSMutableURLRequest *customersRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:blinchURL]];
    customersRequest.HTTPMethod = @"POST";
    
    
    NSDictionary *postData = @{@"firstName": firstName,
                               @"lastName" : lastName,
                               @"emailAddress" : email};
    
    
    // Convert the dictionary into JSON data.
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:postData
                                                       options:0
                                                         error:nil];
    
    customersRequest.HTTPBody = JSONData;
    
    BLIRegistrationProcessingViewController * __weak weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:customersRequest
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         
                                                         NSError *jsonError = nil;
                                                         
                                                         id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                  
                                                         __strong typeof(weakSelf)strongSelf = weakSelf;
                                                         if([strongSelf.delegate conformsToProtocol:@protocol(BLIRegistrationDelegate)]) {
                                                             if (error!=nil) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);

                                                                 [weakSelf.delegate registrationDidFailWithError:error];
                                                             } else {
                                                                 // success forwards to landing view controller
                                                                 NSLog(@"Return data: %@", returnValue);
                                                                 NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                                 [strongSelf.delegate registrationViewControllerDidFinish:(BLIRegistrationViewController *)strongSelf.delegate];
                                                             }
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
