//
//  ScheduleError.h
//  CTA
//
//  Created by Vj on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScheduleError : NSObject {

	NSString *msg;
	NSString *routeId;
	NSUInteger stopId;
	
}
@property(nonatomic,retain) NSString *msg,*routeId;
@property(nonatomic) NSUInteger stopId;
@end
