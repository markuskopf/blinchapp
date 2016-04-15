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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation BLILoginProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.activityIndicator startAnimating];
    
    [self loginWithUsername:self.username password:self.password];
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

//- (void)timerCall {
//    if ([self.delegate conformsToProtocol:@protocol(BLILoginProcessViewControllerDelegate)]) {
//        [self.delegate loginViewControllerDidFinish:(BLILoginViewController*)self.delegate];
//    }
//
//}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
  
    BLILoginProcessViewController * __weak weakSelf = self;
    
    [self.apiClient loginWithUserName:self.username password:self.password completionHandler:^(NSDictionary *response, NSError *error) {
        
        if ([self.delegate conformsToProtocol:@protocol(BLILoginProcessViewControllerDelegate)]) {
            [self.delegate loginViewControllerDidFinish:(BLILoginViewController*)self.delegate];
            
            [weakSelf.activityIndicator stopAnimating];
        }
        
    }];

}
@end
