//
//  BlunchRegistrationViewController.m
//  Blunch
//
//  Created by Markus Kopf on 22.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import "BLIRegistrationViewController.h"
#import "BLICheckInViewController.h"
#import "BLIFacadeManager.h"
#import "BLIConstants.h"
#import "BLIRegistrationProcessingViewController.h"


@interface BLIRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sendRegistrationDetailsButton;
@property (weak, nonatomic) IBOutlet UITextField *registrationEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *registrationFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *registrationLastNameTextField;

@property (strong, nonatomic) NSURLSession *session;


@end

@implementation BLIRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 

    [self configureSession];
    
    // listen to text field change and sanity the input.
    [self.registrationFirstNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.registrationLastNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.registrationEmailTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)configureSession {
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    sessionConfiguration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
    sessionConfiguration.HTTPCookieStorage = nil;
    sessionConfiguration.HTTPShouldSetCookies = NO;
    sessionConfiguration.URLCredentialStorage = nil;
    sessionConfiguration.URLCache = nil;
    sessionConfiguration.timeoutIntervalForRequest = 10.0;
    sessionConfiguration.TLSMinimumSupportedProtocol = kTLSProtocol12;
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Authorization": BLIAuthenticationValue}];
    
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                             delegate:nil
                                        delegateQueue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#define kOFFSET_FOR_KEYBOARD 180.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
       // [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.registrationFirstNameTextField] ||
        [sender isEqual:self.registrationLastNameTextField]||
        [sender isEqual:self.registrationEmailTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:BLIRegistrationProcessSegue]) {
        BLIRegistrationProcessingViewController *registrationProcessViewController = (BLIRegistrationProcessingViewController *)segue.destinationViewController;
        registrationProcessViewController.delegate = self;

    }

}

#pragma mark - AlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayCalendar = [calendar components:(NSCalendarUnitWeekday)
                                                    fromDate:[NSDate date]];
    // trigger notification only every Wed
    if ([weekdayCalendar weekday] == 4) {
        [self performSegueWithIdentifier:@"segueCheckin" sender:nil];
    }
    
    else {
        [self performSegueWithIdentifier:@"segueRegistrationToHistory" sender:nil];
    }
    
    
}

#pragma mark Text Field Input Validation Methods

-(void)textFieldDidChange:(UITextField*) sender {
    // validate if .count > 0
}


#pragma mark - SendRegistrationDetails

- (IBAction) sendRegistrationDetailsButton:(id)sender {
    
   // TODO:
}


#pragma mark - BLIRegistrationDelegate

/**
 * Called after the user has succefully registered to the system.
 */

- (void)registrationViewControllerDidFinish:(BLIRegistrationProcessingViewController *)loginViewController {
    
}

/**
 * highlights errors arising from the login process.
 */

- (void)registrationDidFailWithError:(NSError *)error {
    
}




@end
