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
#import "APIClient.h"

@interface BLILandingViewController ()

@property(nonatomic, strong, readonly) APIClient *apiClient;

@end

@implementation BLILandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewControllerConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewControllerConfiguration {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    _apiClient = [[APIClient alloc] initWithQueue:queue];
}

#pragma mark - Navigations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:BLIRegistrationSegue]) {
        
    } else if ([segue.identifier isEqualToString:BLILoginSegue]) {
        BLILoginViewController *loginViewController = (BLILoginViewController *)segue.destinationViewController;
        loginViewController.apiClient = self.apiClient;
        
    }
}

- (IBAction)registrationPressed:(id)sender {
    
    [self performSegueWithIdentifier:BLIRegistrationSegue sender:sender];
    
}

- (IBAction)loginPressed:(id)sender {
    
    [self performSegueWithIdentifier:BLILoginSegue sender:sender];
    
}

@end
