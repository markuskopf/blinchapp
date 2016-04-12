//
//  HTTPRequestGenerator.h
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 blinch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequestGenerator : NSObject

- (instancetype)initWithEndpointURL:(NSURL *)url;


- (NSMutableURLRequest *)requestWithPath:(NSString *)path
                                  method:(NSString *)httpMethod
                              parameters:(NSDictionary *)params
                               authValue:(NSString *)authValue;

@end
