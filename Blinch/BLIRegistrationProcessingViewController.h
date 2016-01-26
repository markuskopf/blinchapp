//
//  BLIRegistrationProcessingViewController.h
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLIRegistrationViewController;

@protocol BLIRegistrationDelegate <NSObject>

/**
 * Called after the user has succefully registered to the system.
 */
- (void)registrationViewControllerDidFinish:(BLIRegistrationViewController *)registrationViewController;

/**
 * highlights errors arising from the login process.
 */
- (void)registrationDidFailWithError:(NSError *)error;


@end

@interface BLIRegistrationProcessingViewController : UIViewController

@property(weak, nonatomic) id<BLIRegistrationDelegate> delegate;
@property(strong, nonatomic) NSURLSession *session;
@property(copy, nonatomic) NSString *firstName;
@property(copy, nonatomic) NSString *lastName;
@property(copy, nonatomic) NSString *email;


@end
