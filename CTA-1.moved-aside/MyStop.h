//
//  Stop.h
//  CTA
//
//  Created by Vj on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyStop : NSManagedObject {
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *direction;
@property(retain) NSNumber *stopId;
@property(nonatomic,retain) NSString *stopName;



@end
