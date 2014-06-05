//
//  Adventurer.h
//  RaidPlanner
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Adventurer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * species;
@property (nonatomic, retain) NSSet *raids;
@end

@interface Adventurer (CoreDataGeneratedAccessors)

- (void)addRaidsObject:(NSManagedObject *)value;
- (void)removeRaidsObject:(NSManagedObject *)value;
- (void)addRaids:(NSSet *)values;
- (void)removeRaids:(NSSet *)values;

@end
