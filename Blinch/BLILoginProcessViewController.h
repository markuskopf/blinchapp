//
//  BLILoginProcessViewController.h
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLILoginViewController;

@protocol BLILoginProcessViewControllerDelegate <NSObject>

/**
 * Called after the user has succefully logged into the system.
 */
- (void)loginViewControllerDidFinish:(BLILoginViewController *)loginViewController;

/**
 * highlights errors arising from the login process.
 */
- (void)loginDidFailWithError:(NSError *)error;

@end

@interface BLILoginProcessViewController : UIViewController

@property (weak, nonatomic) id<BLILoginProcessViewControllerDelegate> delegate;

@end
