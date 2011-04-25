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

@implementation AllRoutesViewController

@synthesize routes;
@synthesize selectedRouteId;
@synthesize directions;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	CTAWebService *webService = [CTAWebService sharedInstance];
	self.routes = [webService getAllRoutes];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routes count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSUInteger row = [indexPath row];
	Route *route = (Route *) [self.routes objectAtIndex:row];
		
	cell.textLabel.text = route.name;
	cell.detailTextLabel.text=route.routeNumber;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	Route *route = (Route *) [self.routes objectAtIndex:row];
	
	self.selectedRouteId = route.routeNumber;
	
	CTAWebService *service = [CTAWebService sharedInstance];
	self.directions = [service busDirectionForRoute:route];
	
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Bus Direction"
															 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
													otherButtonTitles:nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	for (int i=0; i<[self.directions count]; i++) {
		Direction *dir = [self.directions objectAtIndex:i];
		[actionSheet addButtonWithTitle:dir.bound];
	}
	
	[actionSheet showInView:self.view];
	[actionSheet release];
	
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex != 0 ) {
		AllStopsViewController *viewController =[[AllStopsViewController alloc] initWithStyle:UITableViewStylePlain];
		Direction *dir = [self.directions objectAtIndex:buttonIndex - 1];
		viewController.routeId = self.selectedRouteId;
		viewController.direction = dir.bound;
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
	self.routes = nil;
}


- (void)dealloc {
	[routes release];
    [super dealloc];
}


@end

