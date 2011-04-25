//
//  MyStopViewController.h
//  CTA
//
//  Created by Vj on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRouteIdTag 1
#define kStopNameTag 2
#define kDirectionTag 3

@interface MyStopViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate> {

	UITableViewCell *tableCell;
	@private
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic,retain) IBOutlet UITableViewCell *tableCell;
@end
