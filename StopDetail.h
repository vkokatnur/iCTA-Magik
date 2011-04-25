//
//  StopDetail.h
//  CTA
//
//  Created by Vj on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StopDetail : NSObject {
	
	NSInteger stopId;
	NSString *stopName;
	NSString *routeId;
	NSString *direction;

}
@property(nonatomic) NSInteger stopId;
@property(nonatomic,retain) NSString *stopName, *routeId, *direction;
@end
