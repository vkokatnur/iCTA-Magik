//
//  Master.h
//  CTA
//
//  Created by Vj on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Master :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * loadRoute;
@property (nonatomic, retain) NSNumber * loadStops;
@property (nonatomic, retain) NSDate * lastUpdated;

@end



