//
//  AllStopsViewController.h
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStopNameTag 1
#define kRouteId 2

@class Route;

@interface AllStopsViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {

    Route *route;
	
	NSArray *stopsName;
	NSArray *stopsId;
	UITableViewCell *displayCell;
}
@property(nonatomic,retain) Route *route;

@property(nonatomic,retain) IBOutlet UITableViewCell *displayCell;
@property(nonatomic,retain) NSArray *stopsName;
@property(nonatomic,retain) NSArray *stopsId;

- (IBAction)returnToBusLookUp;

@end
