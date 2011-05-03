//
//  MyStop.h
//  CTA
//
//  Created by Vijay Kokatnur on 5/2/11.
//  Copyright (c) 2011 Nistantrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyStop : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stopId;
@property (nonatomic, retain) NSString * stopName;
@property (nonatomic, retain) NSString * routeId;
@property (nonatomic, retain) NSString * direction;

@end
