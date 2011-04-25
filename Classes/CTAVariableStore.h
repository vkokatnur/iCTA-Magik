//
//  CTAVariableStore.h
//  CTA
//
//  Created by Vj on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CTAVariableStore : NSObject {
	NSString *routeNumber;
	NSString *routeName;
}
@property(nonatomic, retain) NSString *routeNumber;
@property(nonatomic, retain) NSString *routeName;

+(CTAVariableStore *) sharedInstance;
@end
