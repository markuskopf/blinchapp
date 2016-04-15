//
//  BLILoginViewController.h
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"

@interface BLILoginViewController : UIViewController

@property(nonatomic, weak) APIClient *apiClient;

@end
