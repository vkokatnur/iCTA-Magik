//
//  Stops.h
//  CTA
//
//  Created by Vj on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Direction;

@interface Stops :  NSManagedObject  
{
	
}

@property (nonatomic, retain) NSNumber * stopId;
@property (nonatomic, retain) NSString * stopName;
@property (nonatomic, retain) NSSet* route;
@property (nonatomic, retain) Direction * direction;

@end


@interface Stops (CoreDataGeneratedAccessors)
- (void)addRouteObject:(NSManagedObject *)value;
- (void)removeRouteObject:(NSManagedObject *)value;
- (void)addRoute:(NSSet *)value;
- (void)removeRoute:(NSSet *)value;

@end

