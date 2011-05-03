//
//  CTAWebService.h
//  CTA
//
//  Created by Vj on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

extern NSString * const API_KEY;
extern NSString * const URL;
extern NSString * const CURRENT_TIME;
extern NSString * const VEHICLE_LOCATION;
extern NSString * const ALL_ROUTES;
extern NSString * const ROUTE_DIRECTION;
extern NSString * const BUS_STOPS;
extern NSString * const PATTERN_CONSTRUCT;
extern NSString * const BUS_PREDICTION;

@interface CTAWebService : NSObject {

	NSURLConnection *urlConnection;
	NSMutableData *busData;
	NSDateFormatter *dateFormatter;
}

@property(nonatomic,retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic,retain) NSMutableData *busData;

+(CTAWebService *) sharedInstance;

-(NSManagedObject *) initiateFetchFor:(NSString *) modelName forKey:(NSString *) key andValue:(NSString *) value;

-(NSDate *) synchronizeBusTime;
-(void) initRoutes;
-(void) busDirectionForRoute:(Route *) route;

-(NSDictionary *) busStopsForRoute:(NSString *) routeNumber andDirection:(NSString *) direction;
-(void) busPatternForRoute:(NSString *) routeNumber andPattern:(NSInteger) patternId;
-(NSArray *) busPredictionForRoute:(NSString *) routeNumber andStop:(NSUInteger) stopId;

@end
