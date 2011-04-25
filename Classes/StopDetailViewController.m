//
//  StopDetailViewController.m
//  CTA
//
//  Created by Vj on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StopDetailViewController.h"
#import "CTAWebService.h"
#import "BusPrediction.h"
#import "MyStop.h"
#import "StopDetail.h"
#import "CTAAppDelegate.h"

#define ktimeTag 3
#define kDestinationStopTag 2

@implementation StopDetailViewController

@synthesize tableViewCell;
@synthesize stopDetail;
@synthesize busNumber;
@synthesize predictionData;
@synthesize tableHeaderView;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Create and set the table header view.
    if (tableHeaderView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"StopDetailHeader" owner:self options:nil];
        self.tableView.tableHeaderView = tableHeaderView;
        self.tableView.allowsSelectionDuringEditing = YES;
    }
	
	CTAWebService *service = [CTAWebService sharedInstance];
	NSArray *predictions = [service busPredictionForRoute:stopDetail.routeId andStop:stopDetail.stopId];
	self.predictionData = predictions;
	[predictions release];
}


- (IBAction)saveStop {
	MyStop *stop = (MyStop *)[NSEntityDescription insertNewObjectForEntityForName:@"MyStop" 
														   inManagedObjectContext:UIAppDelegate.managedObjectContext];

	//stop.routeId = stopDetail.routeId;
	//stop.stopId = [NSNumber numberWithInteger:stopDetail.stopId];
	//stop.direction = stopDetail.direction;
	//stop.stopName = stopDetail.stopName;
	
	// Commit the change.
	NSError *error;
	if (![UIAppDelegate.managedObjectContext save:&error]) {
		[UIAppDelegate showError:error];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
	
	busNumber.text=stopDetail.routeId;
    [self.tableView reloadData]; 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (section == 0) {
		return 0;
	}
    return [self.predictionData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];
	id<NSObject> fetchedObject = [self.predictionData objectAtIndex:row];
	
	if([fetchedObject class] == [BusPrediction class]) {
		static NSString *CellIdentifier = @"PredictionCellIdentifier";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"PredictionCellView" owner:self options:nil];
			
			if([nib count] > 0)
				cell = self.tableViewCell;
			else {
				NSLog(@"WTF?");
			}
		}
		BusPrediction *prediction = (BusPrediction *)fetchedObject;
		
		UILabel *timeTag = (UILabel *)[cell.contentView viewWithTag:ktimeTag];
		
		NSDateFormatter *formDate = [[NSDateFormatter alloc] init];
		[formDate setDateFormat:@"mm-dd-yyyy HH:mm"];
		timeTag.text=[NSString stringWithFormat:@"%i", prediction.timeToStop];
		[formDate release];
		
		UILabel *colorlbl = (UILabel *)[cell.contentView viewWithTag:kDestinationStopTag];
		
		NSString *lbl = [NSString stringWithFormat:@"%i feet", prediction.distToStop];
		if (prediction.distToStop <= 50) {
			lbl=@"Within eyesight";
		} else if (prediction.distToStop >= 2500) {
			lbl = [NSString stringWithFormat:@"%f miles", floor(prediction.distToStop/5280)];
		}
		colorlbl.text= lbl;
		
		[prediction release];
		
		return cell;
	} else {
		return nil;
	}
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.stopDetail = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[self.stopDetail release];
    [super dealloc];
}


@end
