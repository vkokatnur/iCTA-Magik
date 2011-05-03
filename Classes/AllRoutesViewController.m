//
//  AllRoutesViewController.m
//  CTA
//
//  Created by Vj on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AllRoutesViewController.h"
#import "CTAWebService.h"
#import "AllStopsViewController.h"
#import "Route.h"
#import "Direction.h"
#import "CTAAppDelegate.h"

@implementation AllRoutesViewController

@synthesize selectedRoute;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    self.managedObjectContext = UIAppDelegate.managedObjectContext;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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


- (NSFetchedResultsController *)fetchedResultsController {
    
    [[CTAWebService sharedInstance] initRoutes];
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"routeNumber" ascending:YES];
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

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Route *route = (Route *)[fetchedResultsController objectAtIndexPath:indexPath];

	cell.textLabel.text = route.name;
	cell.detailTextLabel.text=route.routeNumber;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Route *route = (Route *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	self.selectedRoute = route;
	
	CTAWebService *service = [CTAWebService sharedInstance];
	[service busDirectionForRoute:route];
	
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Bus Direction"
															 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
													otherButtonTitles:nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	for (int i=0; i<[[route.directions allObjects]  count]; i++) {
		Direction *dir = [[route.directions allObjects] objectAtIndex:i];
		[actionSheet addButtonWithTitle:dir.bound];
	}
	
	[actionSheet showInView:self.view];
	[actionSheet release];
	
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex != 0 ) {
		AllStopsViewController *viewController =[[AllStopsViewController alloc] initWithStyle:UITableViewStylePlain];
		Direction *dir = [[self.selectedRoute.directions allObjects] objectAtIndex:buttonIndex - 1];
        self.selectedRoute.mainDirection = dir.bound;
        viewController.route = self.selectedRoute;
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.selectedRoute = nil;
}


- (void)dealloc {
	[self.selectedRoute release];
    [super dealloc];
}


@end

