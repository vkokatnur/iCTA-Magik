//
//  StopsViewController.h
//  CTA
//
//  Created by Vj on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StopsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {

	NSArray *stopsName;
	NSArray *stopsId;
}
@property(nonatomic,retain) NSArray *stopsName;
@property(nonatomic,retain) NSArray *stopsId;

@end
