//
//  AppDelegate.m
//  Blunch
//
//  Created by Oberst Tanja on 11.10.14.
//  Copyright (c) 2014 Oberst Tanja. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - Checks if user was already logged in



#pragma mark - Permission for sending Notifications


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

/*
    // TODO: tob uncomment to set reminder notifications on Wednesday > see below
    // notifcation foo
    [self configureNotifications];
    [NSThread sleepForTimeInterval:2];
    
    NSLog(@"didFinishLaunchingWithOptions called");
*/
    
    // Handle launching from a notification
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Calling notifications for Wed


- (void)configureNotifications
{
    // Handle permission so that the user get's the permission alert.
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }

    
    // trigger notification only every Wed
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];


    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear |
                                                                    NSCalendarUnitWeekOfMonth |
                                                                    NSCalendarUnitHour |
                                                                    NSCalendarUnitMinute|
                                                                    NSCalendarUnitSecond |
                                                                    NSCalendarUnitWeekday)
                                                          fromDate:[NSDate date]];
    
    [componentsForFireDate setWeekday: 4] ; //for firing Wednesday
    [componentsForFireDate setHour: 8] ; //for firing 8PM hour
    [componentsForFireDate setMinute:0] ;
    [componentsForFireDate setSecond:0] ;
    

    // Create own in app notification
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];

    
    
//    // Demo Notification after 60 seconds
//    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:60];


    
    // Please discomment if only WED is desired.
//    localNotif.fireDate = [calendar dateFromComponents:componentsForFireDate];
//    localNotif.repeatInterval = kCFCalendarUnitWeekday;
    

    // Notification details TODO:
    localNotif.alertBody = @"Happy Blunch Notification";
    // Set the action button
    localNotif.alertAction = @"OK";
    
    
    // Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"HI" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}



- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
    
    
    
    NSLog(@"didReceiveLocalNotification called");
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


@end
