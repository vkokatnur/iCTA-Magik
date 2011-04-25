//
//  StopsViewController.m
//  CTA
//
//  Created by Vj on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StopsViewController.h"
#import "CTAWebService.h"

@implementation StopsViewController

@synthesize stopsName, stopsId;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) loadStopsWithRouteId:(NSString *) routeId andDirection:(NSString *) direction {
	CTAWebService *service = [CTAWebService sharedInstance];
	NSDictionary *allRoutes = [service busStopsForRoute:routeId andDirection:direction];
	self.stopsName = [allRoutes allValues];
	self.stopsId = [allRoutes allKeys];
	//[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stopsName count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"StopNameCellID";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	NSUInteger row = [indexPath row];
	NSString *rwstopName = [stopsName objectAtIndex:row];
    cell.textLabel.text = rwstopName;
    return cell;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
