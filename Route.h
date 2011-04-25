//
//  Route.h
//  CTA
//
//  Created by Vj on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Direction;
@class Stops;

@interface Route :  NSManagedObject  
{
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * routeNumber;
@property (nonatomic, retain) NSSet* stops;
@property (nonatomic, retain) NSSet* directions;

@end


@interface Route (CoreDataGeneratedAccessors)
- (void)addStopsObject:(Stops *)value;
- (void)removeStopsObject:(Stops *)value;
- (void)addStops:(NSSet *)value;
- (void)removeStops:(NSSet *)value;

- (void)addDirectionsObject:(Direction *)value;
- (void)removeDirectionsObject:(Direction *)value;
- (void)addDirections:(NSSet *)value;
- (void)removeDirections:(NSSet *)value;

@end

