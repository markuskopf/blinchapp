//
//  APIClient.h
//  Blinch
//
//  Created by Markus Kopf on 12/04/16.
//  Copyright © 2016 Oberst Tanja. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginCompletionHandler)(NSDictionary *response, NSError *error);

@interface APIClient : NSObject

@property(nonatomic, strong, readonly) NSOperationQueue *queue;

- (instancetype)initWithQueue:(NSOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

- (void)loginWithUserName:(NSString *)name
                 password:(NSString *)password
        completionHandler:(LoginCompletionHandler)completionHandler;


@end
