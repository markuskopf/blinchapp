//
//  AppDelegate.m
//  Blunch
//
//  Created by Markus Kopf on 11.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import "AppDelegate.h"
#import "Lunch+CoreDataProperties.h"
#import "LunchPartner+CoreDataProperties.h"

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
    
    [self coreDataTestMethod];
    
    return YES;
}


- (void)coreDataTestMethod {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Lunch *lunch = [NSEntityDescription insertNewObjectForEntityForName:@"Lunch" inManagedObjectContext:context];
    lunch.location = @"Pizza";
    
    LunchPartner *partner = [NSEntityDescription insertNewObjectForEntityForName:@"LunchPartner" inManagedObjectContext:context];
    partner.name = @"Mustermann";
    partner.mail = @"mustermann@gmail.com";
    
    lunch.lunchPartner = [[NSMutableSet alloc] initWithObjects:partner, nil];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lunch"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  
    for (Lunch *lunch in fetchedObjects) {
        NSLog(@"Name: %@", lunch.location);

        for (LunchPartner *value in lunch.lunchPartner) {
            NSLog(@"LunchPartner: %@", value.name);
        }
    }
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


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.markus.FailedBankCD" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Blinch" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Blinch.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
