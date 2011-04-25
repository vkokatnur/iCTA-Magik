//
//  CTAVariableStore.m
//  CTA
//
//  Created by Vj on 3/27/11.
//  Copyright 2011 nistantrii. All rights reserved.
//

#import "CTAVariableStore.h"

static CTAVariableStore *sharedInstance = nil;

@implementation CTAVariableStore
@synthesize routeNumber, routeName;

+(id) sharedInstance {
	if (nil == sharedInstance) {
		sharedInstance = [[self alloc] init];
	}
	
	return sharedInstance;
}

@end
