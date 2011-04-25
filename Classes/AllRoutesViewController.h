//
//  AllRoutesViewController.h
//  CTA
//
//  Created by Vj on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AllRoutesViewController : UITableViewController<UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *routes;

	NSString *selectedRouteId;
	NSArray *directions;
}
@property(nonatomic,retain) NSArray *routes;

@property(nonatomic,retain) NSArray *directions;
@property(nonatomic,retain) NSString *selectedRouteId;

@end
