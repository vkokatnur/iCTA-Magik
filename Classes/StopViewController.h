//
//  StopViewController.h
//  CTA
//
//  Created by Vj on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopViewController : UITableViewController {
	NSArray *busRoutes;
	NSArray *busRouteIds;
}
@property(nonatomic,retain) NSArray *busRoutes;
@property(nonatomic,retain) NSArray *busRouteIds;

@end
