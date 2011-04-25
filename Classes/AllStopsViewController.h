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

@interface AllStopsViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {

	@private
		NSString *routeId;
	@private
		NSString *direction;
	
	NSArray *stopsName;
	NSArray *stopsId;
	UITableViewCell *displayCell;
}
@property(nonatomic,retain) NSString *routeId;
@property(nonatomic,retain) NSString *direction;

@property(nonatomic,retain) IBOutlet UITableViewCell *displayCell;
@property(nonatomic,retain) NSArray *stopsName;
@property(nonatomic,retain) NSArray *stopsId;

- (IBAction)returnToBusLookUp;

@end
