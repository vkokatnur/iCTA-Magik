//
//  MyStop.h
//  CTA
//
//  Created by Vj on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface MyStop :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* stop;

@end


@interface MyStop (CoreDataGeneratedAccessors)
- (void)addStopObject:(NSManagedObject *)value;
- (void)removeStopObject:(NSManagedObject *)value;
- (void)addStop:(NSSet *)value;
- (void)removeStop:(NSSet *)value;

@end

