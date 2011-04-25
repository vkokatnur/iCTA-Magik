//
//  BusLookUpViewController.h
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistranii.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusLookUpViewController : UIViewController<UIActionSheetDelegate>{

	UITextField *field;
	UIButton *goBtn;
	NSArray *directions;

}

@property(nonatomic,retain) NSArray *directions;
@property(nonatomic,retain) IBOutlet UIButton *goBtn;

@property(nonatomic,retain) IBOutlet UITextField *field;

-(IBAction) textFieldDoneEditing:(id)sender;
-(IBAction) backgroundTap:(id)sender;

-(IBAction)findStopsForKnownRoute;
-(IBAction)showAllRoutes;

@end
