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

@implementation BusLookUpViewController

@synthesize goBtn;
@synthesize field;
@synthesize directions;

-(IBAction)findStopsForKnownRoute{
	[field resignFirstResponder];
	
	CTAWebService *service = [CTAWebService sharedInstance];
	NSArray *fdirections = [service busDirectionForRoute:field.text];
	self.directions = fdirections;
	[fdirections release];
	
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Bus Direction"
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.destructiveButtonIndex = 2;
	[actionSheet addButtonWithTitle:[directions objectAtIndex:0]];
	[actionSheet addButtonWithTitle:[directions objectAtIndex:1]];
	[actionSheet addButtonWithTitle:@"Cancel"];
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex != 2 ) {
	AllStopsViewController *viewController =[[AllStopsViewController alloc] initWithStyle:UITableViewStylePlain];
	
	viewController.routeId = field.text;
	viewController.direction = [self.directions objectAtIndex:buttonIndex];
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
    [super dealloc];
}


@end
