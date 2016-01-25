//
//  BlunchLotteryViewController.h
//  Blunch
//
//  Created by Markus Kopf on 14.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface BLILotteryViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

- (IBAction)showEmail:(id)sender;

@end
