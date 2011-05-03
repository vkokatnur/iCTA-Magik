//
//  BusLookUpViewController.h
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistranii.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface BusLookUpViewController : UIViewController<UIActionSheetDelegate>{

	UITextField *field;
	UIButton *goBtn;
	Route *route;

}

@property(nonatomic,retain) Route *route;
@property(nonatomic,retain) IBOutlet UIButton *goBtn;

@property(nonatomic,retain) IBOutlet UITextField *field;

-(IBAction) textFieldDoneEditing:(id)sender;
-(IBAction) backgroundTap:(id)sender;

-(IBAction)findStopsForKnownRoute;
-(IBAction)showAllRoutes;

@end
