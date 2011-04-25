//
//  StopDetailViewController.h
//  CTA
//
//  Created by Vj on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StopDetail;

@interface StopDetailViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {

	StopDetail *stopDetail;
	
	NSArray *predictionData;
	
	UITableViewCell *tableViewCell;
	UIView *tableHeaderView;
	
	UILabel *busNumber;
	
}
@property(nonatomic,retain) IBOutlet UILabel *busNumber;

@property(nonatomic,retain) StopDetail *stopDetail;
@property(nonatomic,retain) IBOutlet UITableViewCell *tableViewCell;
@property(nonatomic,retain) NSArray *predictionData;
@property(nonatomic,retain) IBOutlet UIView *tableHeaderView;

-(IBAction) saveStop;

@end
