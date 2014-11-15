//
//  BlunchLotteryViewController.m
//  Blunch
//
//  Created by Oberst Tanja on 14.10.14.
//  Copyright (c) 2014 Oberst Tanja. All rights reserved.
//

#import "BlunchLotteryViewController.h"
#import <MessageUI/MessageUI.h>

@interface BlunchLotteryViewController ()

@property (strong, nonatomic) NSArray *blunchNames;
@property (strong, nonatomic) NSDictionary  *myData;

@property (strong, nonatomic) NSArray *emailTitle;
@property (strong, nonatomic) NSArray *messageBody;
@property (strong, nonatomic) NSArray *toRecipents;
@property (weak, nonatomic) IBOutlet UIPickerView *lotteryPicker;

@property (nonatomic) BOOL alreadyChoosen;

@end


@implementation BlunchLotteryViewController

- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Blunch meeting point";
    // Email Content
    NSString *messageBody = @"<h1>Looking forward to meeting you for Blunch today!</h1><p>When:</p><p>Where:</p>"; // Change the message body to HTML
    // To address
    
    NSInteger row = [self.lotteryPicker selectedRowInComponent:0];
    NSString *key = [self.myData.allKeys objectAtIndex:row];
    NSString *mail = [self.myData valueForKey:key];
    
    NSArray *toRecipents = [NSArray arrayWithObject:mail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];

}


#pragma mark - MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController *)composer didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [[[UIAlertView alloc] initWithTitle:@"Cancel"
                                        message:@"Are you sure? ;)"
                                       delegate:self
                              cancelButtonTitle:@"Yes, cancel!"
                              otherButtonTitles:nil] show];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"Awesome"
                                        message:@"The reply will be sent to your email adress you signed up with."
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier: @"historySegue" sender: self];
    
  
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.myData.count;
    
//    return [self.blunchNames count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.myData.allKeys objectAtIndex:row];
    
//    return self.blunchNames [row];
}

#pragma mark - View

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.alreadyChoosen) {
        [self.lotteryPicker selectRow: (arc4random() % [self.myData.allKeys
                                                        count]) inComponent: 0 animated: YES];
          self.alreadyChoosen = YES;
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if (!self.alreadyChoosen) {
//        [self.lotteryPicker selectRow:2 inComponent:0 animated:YES];
//        self.alreadyChoosen = YES;
//    }
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;

    self.alreadyChoosen = NO;
    
    
    self.myData = @{@"Jonas": @"jonas.jerlstrom@hyperisland.se",
                    @"Ida": @"ida.reimersh@hyperisland.se",
                    @"Ali": @"ali.rodsari@hyperisland.se",
                    @"Unni": @"unni.lindahl@hyperisland.se",
                    @"Raquel": @"raquel.pisetta@hyperisland.se",
                    @"Darryl": @"darryl.east@hyperisland.se",
                    @"Tage": @"markus.winberg@hyperisland.se",
                    @"Doyeon": @"mdoyeon.kim@hyperisland.se",
                    @"Sara": @"sara.bernhardsson@hyperisland.se",
                    @"Sandra": @"sandra.oster@hyperisland.se",
                    @"Fritz": @"fridgeir.asgeirsson@hyperisland.se",
                    @"Paul": @"paul.nino@hyperisland.se",
                    @"Madeleine": @"madeleine.melcher@hyperisland.se",
                    @"Ejay": @"elaine.dagdayan@hyperisland.se",
                    @"Petter": @"petter.andersson@hyperisland.se",
                    @"Max": @"max.stralka@hyperisland.se",
                    @"Sylvia": @"sylvia.dickoh@hyperisland.se",
                    @"Johanna": @"johanna.bulling@hyperisland.se"};
    

    
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
