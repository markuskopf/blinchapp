//
//  BlunchCheckInViewController.m
//  Blunch
//
//  Created by Markus Kopf on 13.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import "BLICheckInViewController.h"

@interface BLICheckInViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkInYesButton;
@property (weak, nonatomic) IBOutlet UIButton *checkInNoButton;

@end

@implementation BLICheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
