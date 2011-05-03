//
//  BusLookUpViewController.m
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistantrii.com. All rights reserved.
//

#import "BusLookUpViewController.h"
#import "AllStopsViewController.h"
#import "CTAWebService.h"
#import "AllRoutesViewController.h"
#import "Route.h"
#import "Direction.h"

@implementation BusLookUpViewController

@synthesize goBtn;
@synthesize field;
@synthesize route;

-(IBAction)findStopsForKnownRoute{
	[field resignFirstResponder];
	
	CTAWebService *service = [CTAWebService sharedInstance];
    Route *selRoute =(Route *) [service initiateFetchFor:@"Route" forKey:@"routeNumber" andValue:field.text];
	self.route = selRoute;
    
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Bus Direction"
															 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
													otherButtonTitles:nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	for (int i=0; i<[[selRoute.directions allObjects]  count]; i++) {
		Direction *dir = [[selRoute.directions allObjects] objectAtIndex:i];
		[actionSheet addButtonWithTitle:dir.bound];
	}
	
	[actionSheet showInView:self.view];
	[actionSheet release];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex != 0 ) {
        AllStopsViewController *viewController =[[AllStopsViewController alloc] initWithStyle:UITableViewStylePlain];
        self.route.mainDirection = [[self.route.directions allObjects] objectAtIndex:buttonIndex - 1];
        viewController.route = self.route;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
	}
}

-(IBAction) showAllRoutes {
	NSLog(@"IN all stops");
	AllRoutesViewController *viewController =[[AllRoutesViewController alloc] initWithStyle:UITableViewStylePlain];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}
-(IBAction) textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
	[self findStopsForKnownRoute];
}

// wtf??
-(IBAction) backgroundTap:(id)sender {
	[field resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.field = nil;
	self.goBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.goBtn release];
	[self.field release];
    [self.route release];
    [super dealloc];
}


@end
