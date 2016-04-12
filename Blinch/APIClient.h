//
//  APIClient.h
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property(nonatomic, strong, readonly) NSOperationQueue *queue;

- (instancetype)initWithQueue:(NSOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

- (void)loginWithUserName:(NSString *)name
                 password:(NSString *)password
        completionHandler:(void (^)(NSDictionary *response, NSDictionary *meta, NSError *error))completionHandler;


@end
