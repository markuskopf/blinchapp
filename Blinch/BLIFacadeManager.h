//
//  BLIFacadeManager.h
//  Blinch
//
//  Created by Markus Kopf on 06/01/15.
//  Copyright (c) 2015 Oberst Tanja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLIFacadeManager : NSObject


+ (BLIFacadeManager *)sharedInstance;


- (BOOL)registration:(NSString *)mail name:(NSString*)name;

- (BOOL)status;

- (void)checkin;

- (void)checkout;



@end
