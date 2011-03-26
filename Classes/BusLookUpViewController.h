//
//  BusLookUpViewController.h
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistranii.com All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFirstDigit	0
#define kSecondDigit 1
#define kThirdDigit 2
#define kFourthDigit 3

@interface BusLookUpViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {

	UIPickerView *picker;
	UIButton *goBtn;
	
	NSArray *digits;
	NSArray *letters;
}
@property(nonatomic,retain) IBOutlet UIPickerView *picker;
@property(nonatomic,retain) IBOutlet UIButton *goBtn;
@property(nonatomic,retain) NSArray *digits;
@property(nonatomic,retain) NSArray *letters;

-(IBAction)routeValueChanged;
-(IBAction)findStopsForKnownRoute;
-(IBAction)showAllRoutes;

@end
