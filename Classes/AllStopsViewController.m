//
//  AllStopsViewController.m
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistantrii.com. All rights reserved.
//

#import "AllStopsViewController.h"
#import "CTAWebService.h"
#import "StopDetailViewController.h"
#import "StopDetail.h"

@implementation AllStopsViewController

@synthesize route;

@synthesize displayCell;
@synthesize stopsName;
@synthesize stopsId;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	CTAWebService *service = [CTAWebService sharedInstance];
	NSDictionary *allRoutes = [service busStopsForRoute:route.routeNumber andDirection:route.mainDirection];
	self.stopsName = [allRoutes allValues];
	self.stopsId = [allRoutes allKeys];
	self.title = [NSString stringWithFormat:@"Route %@",route.routeNumber];
	}

- (void)viewWillAppear:(BOOL)animated {
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedRowIndexPath != nil) {
        [self.tableView deselectRowAtIndexPath:selectedRowIndexPath animated:NO];
    }
}

- (IBAction)returnToBusLookUp {
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionTitle = [NSString stringWithFormat:@"Direction : %@", route.mainDirection];
	return sectionTitle;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stopsName count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"StopNameCellID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
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

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	StopDetailViewController *detailViewController = [[StopDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	StopDetail *detail = [[StopDetail alloc] init];
	
	detail.routeId = self.route.routeNumber;	
	detail.direction =self.route.mainDirection;

	NSUInteger row = [indexPath row];
	detail.stopId = [[stopsId objectAtIndex:row] intValue];
	detail.stopName = [stopsName objectAtIndex:row];
	
	detailViewController.stopDetail = detail;
	[detail release];
	
    [self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

- (void)didReceiveMemoryWarning {
	[self.stopsName release];
	[self.stopsId release];
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.stopsName = nil;
	self.stopsId = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.stopsName release];
	[self.stopsId release]; 
    [super dealloc];
}


@end
