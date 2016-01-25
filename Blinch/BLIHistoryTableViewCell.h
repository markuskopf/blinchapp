//
//  BlunchHistoryTableViewCell.h
//  Blunch
//
//  Created by Markus Kopf on 11.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLIHistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
