//
//  Lunch+CoreDataProperties.h
//  
//
//  Created by Markus Kopf on 27/01/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Lunch.h"

NS_ASSUME_NONNULL_BEGIN

@interface Lunch (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *lunchDate;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSSet<LunchPartner *> *lunchPartner;

@end

@interface Lunch (CoreDataGeneratedAccessors)

- (void)addLunchPartnerObject:(LunchPartner *)value;
- (void)removeLunchPartnerObject:(LunchPartner *)value;
- (void)addLunchPartner:(NSSet<LunchPartner *> *)values;
- (void)removeLunchPartner:(NSSet<LunchPartner *> *)values;

@end

NS_ASSUME_NONNULL_END
