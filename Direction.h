//
//  Direction.h
//  CTA
//
//  Created by Vijay Kokatnur on 5/2/11.
//  Copyright (c) 2011 Nistantrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Route;

@interface Direction : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * bound;
@property (nonatomic, retain) Route * route;

@end
