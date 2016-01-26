//
//  BLILoginProcessViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "BLILoginProcessViewController.h"

@interface BLILoginProcessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *logginInLabel;

@end

@implementation BLILoginProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.hidesBackButton = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(timerCall)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)timerCall {
    if ([self.delegate conformsToProtocol:@protocol(BLILoginProcessViewControllerDelegate)]) {
        [self.delegate loginViewControllerDidFinish:(BLILoginViewController*)self.delegate];
    }

}


- (void)loginWithUser:(NSString *)user password:(NSString *)password {
    
    if ([self.delegate conformsToProtocol:@protocol(BLILoginProcessViewControllerDelegate)]) {
        [self.delegate loginViewControllerDidFinish:(BLILoginViewController*)self.delegate];
    }
    
}


@end
