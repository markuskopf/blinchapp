//
//  AppDelegate.h
//  Blunch
//
//  Created by Markus Kopf on 11.10.14.
//  Copyright (c) 2014 Markus Kopf. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

