//
//  BlinchErrors.h
//  Blinch
//
//  Created by Markus Kopf on 13/04/16.
//  Copyright © 2016 Blinch. All rights reserved.
//

#import <Foundation/Foundation.h>

NSError *ErrorWithCode(NSInteger code, NSError *underlyingError);

/** Blinch error domain. */
extern NSString * const BlinchErrorDomain;

enum {
    /**
     * Unauthorized error.
     */
    BlinchUnauthorizedError = 401,
    
    /**
     * Server access error
     */
    BlinchServerAccessError = 403
};
