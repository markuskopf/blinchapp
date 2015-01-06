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
        
    return YES;
}


@end
