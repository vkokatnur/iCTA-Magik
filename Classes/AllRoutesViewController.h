//
//  AllRoutesViewController.h
//  CTA
//
//  Created by Vj on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Route;

@interface AllRoutesViewController : UITableViewController<UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate> {

	Route *selectedRoute;
    
@private
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property(nonatomic,retain) Route *selectedRoute;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
