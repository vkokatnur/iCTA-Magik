//
//  BusLookUpViewController.m
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright 2011 nistranii.com. All rights reserved.
//

#import "BusLookUpViewController.h"


@implementation BusLookUpViewController

@synthesize picker;
@synthesize goBtn;
@synthesize digits;
@synthesize letters;

- (void)viewDidLoad {
	NSArray *initDigits = [[NSArray alloc] initWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
	self.digits=initDigits;
	[initDigits release];
	
	
	NSArray *initLetters = [[NSArray alloc] initWithObjects:@" ",@"x",nil];
	self.letters=initLetters;
	[initLetters release];
	
	[super viewDidLoad];
}

-(IBAction)routeValueChanged {
	NSLog(@"trmTxt value");	
}

-(IBAction)findStopsForKnownRoute{
	NSLog(@"IN findStopsForKnownRoute");
}

-(IBAction) showAllRoutes {
	NSLog(@"IN all stops");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == kFourthDigit) {
		return [self.letters count];
	}
	
	return [self.digits count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if(component == kFourthDigit)
		return [self.letters objectAtIndex:row];
	
	return [self.digits objectAtIndex:row];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.digits = nil;
	self.letters = nil;
	self.goBtn = nil;
	self.picker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.picker release];
	[self.goBtn release];
	[self.digits release];
	[self.letters release];
    [super dealloc];
}


@end
