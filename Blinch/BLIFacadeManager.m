//
//  BLIFacadeManager.m
//  Blinch
//
//  Created by Markus Kopf on 06/01/15.
//  Copyright (c) 2015 Oberst Tanja. All rights reserved.
//

#import "BLIFacadeManager.h"
#import <UIKit/UIKit.h>

@implementation BLIFacadeManager

static BLIFacadeManager *sharedInstance = nil;

+ (BLIFacadeManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}


- (id)init
{
    self = [super init];
    if (self) {
        
    }
 
    return self;
}




- (BOOL)registration:(NSString *)mail name:(NSString*)name
{
    
    
    
    return YES;
}


- (BOOL)status
{
    NSString *blinchURL = @"http://192.168.0.15:8080/v1/status";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:blinchURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *responseData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Message" message:[responseData valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Server Message" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
        });
        
        
        
    }] resume];
    
    
    return YES;
}


@end
