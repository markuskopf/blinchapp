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

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation BLILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self controllerConfiguration];
}

- (void)controllerConfiguration {
    
    // if test environment
    self.userNameTextField.text = @"kopf.markus@blinchapp.com";
    self.passwordTextField.text = @"12345678";
    
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
        destinationViewController.apiClient = self.apiClient;
        destinationViewController.username = self.userNameTextField.text;
        destinationViewController.password = self.passwordTextField.text;
    }

}

- (IBAction)loginPressed:(id)sender {
    
    if (self.userNameTextField.text.length > 0 &&
        self.passwordTextField.text.length > 0) {
        [self performSegueWithIdentifier:BLILoginProcessSegue sender:self];
    }
    
    // TODO: Show information since required data is missing. Enable login button only when all data is complete.
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
    [self presentAlertViewWithError:error];
}

#pragma mark - Login error

- (void)presentAlertViewWithError:(NSError *)error {
    if([[UIDevice currentDevice].systemVersion floatValue] < 8.0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Login Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self)weakSelf = self;
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [alertViewController addAction:okAction];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
}

#pragma mark - AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
