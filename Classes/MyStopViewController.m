//
//  MyStopViewController.m
//  CTA
//
//  Created by Vj on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyStopViewController.h"
#import "MyStop.h"
#import "CTAAppDelegate.h"
#import "StopDetailViewController.h"
#import "StopDetail.h";

@implementation MyStopViewController

@synthesize tableCell;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    // Configure the navigation bar

	self.managedObjectContext = UIAppDelegate.managedObjectContext;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;


	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyStop" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"routeId" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] 
																 initWithFetchRequest:fetchRequest 
																					managedObjectContext:managedObjectContext sectionNameKeyPath:nil 
																											   cacheName:nil];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
} 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"StopDetailCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"MyStopTableView" owner:self options:nil];
		
		if([nib count] > 0)
			cell = self.tableCell;
		else {
			NSLog(@"WTF?");
		}
	}
    
    MyStop *stop = (MyStop *)[fetchedResultsController objectAtIndexPath:indexPath];
    
	UILabel *routelbl = (UILabel *)[cell.contentView viewWithTag:kRouteIdTag];
	routelbl.text=stop.routeId;
	
	UILabel *stoplbl = (UILabel *)[cell.contentView viewWithTag:kStopNameTag];
	stoplbl.text=stop.stopName;
	
	UILabel *dirlbl = (UILabel *)[cell.contentView viewWithTag:kDirectionTag];
    dirlbl.text=stop.direction;
	
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	StopDetailViewController *detailViewController = [[StopDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	MyStop *stop = (MyStop *)[fetchedResultsController objectAtIndexPath:indexPath];
	
    [self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

