//
//  BLILoginViewController.m
//  Blinch
//
//  Created by Markus Kopf on 25/01/16.
//  Copyright © 2016 Markus Kopf. All rights reserved.
//

#import "BLILoginViewController.h"

@interface BLILoginViewController () 

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - BLILoginProcessViewControllerDelegate

- (void)loginViewControllerDidFinish:(BLILoginProcessViewController *)loginViewController {
    
}

/**
 * highlights errors arising from the login process.
 */

- (void)loginDidFailWithError:(NSError *)error {
    
}

@end
