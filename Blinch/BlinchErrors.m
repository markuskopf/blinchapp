//
//  BlinchErrors.m
//  Blinch
//
//  Created by Markus Kopf on 13/04/16.
//  Copyright © 2016 Blinch. All rights reserved.
//

#import "BlinchErrors.h"

NSError *ErrorWithCode(NSInteger code, NSError *underlyingError) {
    
    NSString *description = nil;
    switch (code) {
        case BlinchUnauthorizedError:
            description = NSLocalizedString(@"Credentials error.", @"Error description.");
            break;
        case BlinchServerAccessError:{
            if (underlyingError){
                description = underlyingError.localizedDescription;
            }else {
                description = NSLocalizedString(@"Error", @"Error description.");
            }
        }
            break;
        default:
            break;
    }
    
    NSMutableDictionary *userInfo = nil;
    if (description != nil || underlyingError != nil) {
        userInfo = [[NSMutableDictionary alloc] init];
        if (description != nil) {
            userInfo[NSLocalizedDescriptionKey] = description;
        }
    }
    
    return [NSError errorWithDomain:BlinchErrorDomain code:code userInfo:userInfo];
}

NSString * const BlinchErrorDomain = @"BlinchErrorDomain";