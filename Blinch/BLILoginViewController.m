//
//  BLILoginViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "BLILoginViewController.h"
#import "BLILoginProcessViewController.h"
#import "BLIConstants.h"

@interface BLILoginViewController () <BLILoginProcessViewControllerDelegate>

@end

@implementation BLILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:BLILoginProcessSegue]) {
        BLILoginProcessViewController *destinationViewController = (BLILoginProcessViewController*)segue.destinationViewController;
        destinationViewController.delegate = self;
    }

}


- (IBAction)loginPressed:(id)sender {
     [self performSegueWithIdentifier:BLILoginProcessSegue sender:nil];
    
}

#pragma mark - BLILoginProcessViewController

/**
 * Called after the user has succefully logged into the system.
 */
- (void)loginViewControllerDidFinish:(BLILoginProcessViewController *)loginViewController {
    [loginViewController performSegueWithIdentifier:BLICheckinSegue sender:nil];
}

/**
 * highlights errors arising from the login process.
 */
- (void)loginDidFailWithError:(NSError *)error {
    
}


@end
