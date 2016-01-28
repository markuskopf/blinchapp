//
//  LunchPartner+CoreDataProperties.h
//  
//
//  Created by Markus Kopf on 27/01/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LunchPartner.h"

NS_ASSUME_NONNULL_BEGIN

@interface LunchPartner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) Lunch *lunch;

@end

NS_ASSUME_NONNULL_END
