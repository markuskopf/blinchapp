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

@end

@implementation BLILandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:BLIRegistrationSegue]) {
        // handle data if necessary
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

@end
