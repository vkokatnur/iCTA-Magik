//
//  Route.m
//  CTA
//
//  Created by Vijay Kokatnur on 5/2/11.
//  Copyright (c) 2011 Nistantrii. All rights reserved.
//

#import "Route.h"
#import "Direction.h"


@implementation Route
@dynamic name;
@dynamic routeNumber;
@dynamic mainDirection;
@dynamic lastUpdate;
@dynamic directions;

- (void)addDirectionsObject:(Direction *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"directions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"directions"] addObject:value];
    [self didChangeValueForKey:@"directions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeDirectionsObject:(Direction *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"directions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"directions"] removeObject:value];
    [self didChangeValueForKey:@"directions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addDirections:(NSSet *)value {    
    [self willChangeValueForKey:@"directions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"directions"] unionSet:value];
    [self didChangeValueForKey:@"directions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeDirections:(NSSet *)value {
    [self willChangeValueForKey:@"directions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"directions"] minusSet:value];
    [self didChangeValueForKey:@"directions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
