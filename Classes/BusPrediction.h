//
//  BusPrediction.h
//  CTA
//
//  Created by Vj on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusPrediction : NSObject {

	NSDate *tmpStmp;
	NSString *stopName;
	NSString *stopId;
	NSDate *predictedTime;
	NSString *routeDirection;
	NSString *busNumber;
	NSUInteger distToStop;
	NSInteger timeToStop;
}
@property(nonatomic,retain) NSString *stopName;
@property(nonatomic,retain) NSString *stopId;
@property(nonatomic,retain) NSDate *predictedTime;
@property(nonatomic,retain) NSString *routeDirection;
@property(nonatomic,retain) NSString *busNumber;
@property(nonatomic) NSUInteger distToStop;
@property(nonatomic) NSInteger timeToStop;
@property(nonatomic,retain) NSDate *tmpStmp;


@end
