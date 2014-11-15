//
//  BlunchDrawPartnerViewController.m
//  Blunch
//
//  Created by Oberst Tanja on 13.10.14.
//  Copyright (c) 2014 Oberst Tanja. All rights reserved.
//

#import "BlunchDrawPartnerViewController.h"

@interface BlunchDrawPartnerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *drawPartnerButton;

@end

@implementation BlunchDrawPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
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

@end
