//
//  Route.h
//  CTA
//
//  Created by Vijay Kokatnur on 5/2/11.
//  Copyright (c) 2011 Nistantrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Direction;

@interface Route : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * routeNumber;
@property (nonatomic, retain) NSString * mainDirection;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSSet* directions;

- (void)addDirectionsObject:(Direction *)value;

@end
