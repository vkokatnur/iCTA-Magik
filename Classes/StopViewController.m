//
//  StopViewController.m
//  CTA
//
//  Created by Vj on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StopViewController.h"
#import "CTAVariableStore.h"
#import "CTAWebService.h"

@implementation StopViewController

@synthesize busRoutes, busRouteIds;

-(void) viewDidLoad {
	
	if (busRoutes == nil || busRouteIds == nil) {
		CTAVariableStore *variableStore = [CTAVariableStore sharedInstance];
	
		CTAWebService *webService = [CTAWebService sharedInstance];
		NSDictionary *dictionary = [webService busStopsForRoute:[variableStore getRouteNumberFromArray] andDirection:@"East Bound"];
	
		self.busRoutes = [dictionary allValues];
		self.busRouteIds = [dictionary allKeys];
	}
	
	[super viewDidLoad];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
	return [busRoutes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *StopCellIdentifier = @"StopCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StopCellIdentifier];
	
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StopCellIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	NSString *rowString = [busRoutes objectAtIndex:row];
	cell.textLabel.text = rowString;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	[rowString release];
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog(@"You selected route %@ with id %d", 
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
}
-(void) viewDidUnload {
	self.busRoutes = nil;
	self.busRouteIds = nil;
	[super viewDidUnload];
}

-(void) dealloc {
	[busRoutes release];
	[busRouteIds release];
	[super dealloc];
}

@end
