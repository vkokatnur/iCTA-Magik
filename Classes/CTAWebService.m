//
//  CTAWebService.m
//  CTA
//
//  Created by Vj on 3/25/11.
//  Copyright 2011 nistantrii.com All rights reserved.
//

#import "CTAWebService.h"
#import "TBXML.h"
#import "CTAAppDelegate.h"
#import "BusPrediction.h"
#import "ScheduleError.h"
#import "CTAAppDelegate.h"
#import "Master.h"
#import "Route.h"
#import "Direction.h"

NSString * const API_KEY = @"aTQExNWqZQzigvDmrmLE9ZQnZ";

NSString * const URL = @"http://www.ctabustracker.com/bustime/api/v1";

NSString * const CURRENT_TIME=@"/gettime?";

NSString * const VEHICLE_LOCATION=@"/getvehicles?";

NSString * const ALL_ROUTES=@"/getroutes?";

NSString * const ROUTE_DIRECTION=@"/getdirections?";

NSString * const BUS_STOPS=@"/getstops?";

NSString * const PATTERN_CONSTRUCT=@"/getpatterns?";

NSString * const BUS_PREDICTION=@"/getpredictions?";

static CTAWebService *ctaSharedInstance;

@interface CTAWebService (daoMethods) 
-(NSManagedObjectContext *) initiateContext;
-(NSFetchRequest *) initiateFetchFor:(NSString *) modelName sortBy:(NSString *) sortColumn;
@end

@implementation CTAWebService

@synthesize dateFormatter;
@synthesize urlConnection;
@synthesize busData;

+(id) sharedInstance {
	if (nil == ctaSharedInstance) {
		ctaSharedInstance = [[self alloc] init];
	}
	
	return ctaSharedInstance;
}

-(NSManagedObjectContext * ) initiateContext {
	NSManagedObjectContext *importContext = [[NSManagedObjectContext alloc] init];
	NSPersistentStoreCoordinator *coordinator = [UIAppDelegate persistentStoreCoordinator];
	
	[importContext setPersistentStoreCoordinator:coordinator];	
	[importContext setUndoManager:nil];
	
	return importContext;
}

-(NSFetchRequest *) initiateFetchFor:(NSString *) modelName sortBy :(NSString *) sortColumn {
	NSEntityDescription *desc = [NSEntityDescription entityForName:modelName 
											inManagedObjectContext:UIAppDelegate.managedObjectContext];
	
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	
	if(sortColumn != nil) {
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortColumn ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[req setSortDescriptors:sortDescriptors];
		
	}
	[req setEntity:desc];
	
	return req;
	
}


-(void) initConnection:(NSString *) queryParams {
	
	if(self.dateFormatter == nil){
		self.dateFormatter = [[NSDateFormatter alloc] init];
		[self.dateFormatter setDateFormat:@"yyyymmdd HH:mm"];
	}
	
	self.busData =[NSMutableData data];
	NSString *urlString = [URL stringByAppendingString:queryParams];
	NSLog(@"printing url-> %@",urlString);
	NSURL *url =[NSURL URLWithString:urlString];
	
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
	
	NSError *error;
	NSURLResponse *response;
	[self.busData appendData:[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]];
	if (self.busData == nil) {
		[UIAppDelegate showError:error];
	}
}

-(NSDate *) synchronizeBusTime {
	NSString *queryParams = [[NSString alloc] initWithFormat:@"%@key=%@", CURRENT_TIME, API_KEY];
	[self initConnection:queryParams];
	[queryParams release];
	
	TBXML * tbxml = [[TBXML tbxmlWithXMLData:self.busData] retain];
	TBXMLElement *timeStampElement = [TBXML childElementNamed:@"tm" parentElement: tbxml.rootXMLElement];
	NSString *timeStamp = [TBXML textForElement:timeStampElement];
	NSDate *date = [[NSDateFormatter alloc] dateFromString:timeStamp];
	
	self.busData=nil;
	[tbxml release];
	return date;
}

-(NSArray *) getAllRoutes {
	NSLog(@"%i",[UIAppDelegate.masterRec.loadRoute boolValue]);
	if ([UIAppDelegate.masterRec.loadRoute boolValue] == YES) {
		
		NSManagedObjectContext *importContext = [self initiateContext];
		
		NSString *queryParams = [[NSString alloc] initWithFormat:@"%@key=%@", ALL_ROUTES, API_KEY];
		[self initConnection:queryParams];
		[queryParams release];
		
		TBXML * tbxml = [[TBXML tbxmlWithXMLData:self.busData] retain];
		TBXMLElement *rootElement =tbxml.rootXMLElement;
		
		TBXMLElement *busRouteElement = [TBXML childElementNamed:@"route" parentElement:rootElement];
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		while(busRouteElement != nil){
			TBXMLElement *routeId = [TBXML childElementNamed:@"rt" parentElement:busRouteElement];
			TBXMLElement *routeName = [TBXML childElementNamed:@"rtnm" parentElement:busRouteElement];
			
			Route *route = (Route *)[NSEntityDescription insertNewObjectForEntityForName:@"Route" 
																  inManagedObjectContext:importContext];
			route.name = [TBXML textForElement:routeName];
			route.routeNumber = [TBXML textForElement:routeId];
			
			busRouteElement = [TBXML nextSiblingNamed:@"route" searchFromElement:busRouteElement];
		}
		
		NSError *error;
		if(![importContext save:&error]){
			NSLog(@"%d", [error localizedDescription]);
		}
		
		self.busData=nil;
		[tbxml release];
		
		[UIAppDelegate updateMasterWithRoute:0 andStop:-1];
		[importContext reset]; 
		[pool drain];
		
	} 
	NSFetchRequest *req = [self initiateFetchFor:@"Route" sortBy:@"routeNumber"];
	
	NSArray *objs = [UIAppDelegate.managedObjectContext executeFetchRequest:req error:nil];
	
	NSLog(@"count %d", [objs count]);
	[req release];
	return objs;
}

-(NSArray *) busDirectionForRoute:(Route *) route {
	
	NSArray *objs = [[NSArray alloc] initWithArray:[route.directions allObjects]];
	
	if([objs count] == 0){
		
		NSString *queryParams = [[NSString alloc] initWithFormat:@"%@key=%@&rt=%@", ROUTE_DIRECTION, API_KEY,route.routeNumber];
		[self initConnection:queryParams];
		[queryParams release];
		
		TBXML * tbxml = [[TBXML tbxmlWithXMLData:self.busData] retain];
		TBXMLElement *rootElement =tbxml.rootXMLElement;
		
		NSManagedObjectContext *context = [route managedObjectContext];
		
		TBXMLElement *busDirectionElement = [TBXML childElementNamed:@"dir" parentElement:rootElement];
		while(busDirectionElement != nil){
			Direction *direction = [NSEntityDescription insertNewObjectForEntityForName:@"Direction" 
																 inManagedObjectContext:context];
			direction.bound = [TBXML textForElement:busDirectionElement];
			[route addDirectionsObject:direction];			
			busDirectionElement = [TBXML nextSiblingNamed:@"dir" searchFromElement:busDirectionElement];
		}
		
		NSError *error = nil;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		}
		
		objs = [[NSArray alloc] initWithArray:[route.directions allObjects]];
		self.busData=nil;
	}
	return objs; 
}

-(NSDictionary *) busStopsForRoute:(NSString *) routeNumber andDirection:(NSString *) direction{
	NSString *queryParams = [[NSString alloc] initWithFormat:@"%@key=%@&rt=%@&dir=%@", BUS_STOPS, API_KEY, routeNumber, 
							 [direction stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[self initConnection:queryParams];
	[queryParams release];
	
	TBXML * tbxml = [[TBXML tbxmlWithXMLData:self.busData] retain];
	TBXMLElement *rootElement =tbxml.rootXMLElement;
	
	NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
	
	TBXMLElement *busRouteElement = [TBXML childElementNamed:@"stop" parentElement:rootElement];
	while(busRouteElement != nil){
		TBXMLElement *routeId = [TBXML childElementNamed:@"stpid" parentElement:busRouteElement];
		TBXMLElement *routeName = [TBXML childElementNamed:@"stpnm" parentElement:busRouteElement];
		NSString *routeNameString = [[TBXML textForElement:routeName] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
		[mutableDictionary setObject:routeNameString forKey:[TBXML textForElement:routeId]];
		
		busRouteElement = [TBXML nextSiblingNamed:@"stop" searchFromElement:busRouteElement];
	}
	
	self.busData=nil;
	NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:[mutableDictionary allValues] forKeys:[mutableDictionary allKeys]];
	[mutableDictionary release];
	[tbxml release];
	return dictionary;
}

-(void) busPatternForRoute:(NSString *) routeNumber andPattern:(NSInteger) patternId{
	
}

-(NSArray *) busPredictionForRoute:(NSString *) routeNumber andStop:(NSUInteger) stopId{
	NSString *queryParams = [[NSString alloc] initWithFormat:@"%@key=%@&rt=%@&stpid=%d",BUS_PREDICTION, API_KEY, routeNumber,stopId];
	[self initConnection:queryParams];
	[queryParams release];
	
	TBXML * tbxml = [[TBXML tbxmlWithXMLData:self.busData] retain];
	TBXMLElement *rootElement =tbxml.rootXMLElement;
	
	NSMutableArray *mutableDirections = [[NSMutableArray alloc] init];
	TBXMLElement *busPredictionElement = [TBXML childElementNamed:@"prd" parentElement:rootElement];
	
	if (busPredictionElement == nil) {
		busPredictionElement = [TBXML childElementNamed:@"error" parentElement:rootElement];
		ScheduleError *error = [[ScheduleError alloc] init];
		
		TBXMLElement *rtIdEle = [TBXML childElementNamed:@"rt" parentElement:busPredictionElement];
		error.routeId = [TBXML textForElement:rtIdEle];
		
		TBXMLElement *stopIdEle = [TBXML childElementNamed:@"stpid" parentElement:busPredictionElement];
		error.stopId = [[TBXML textForElement:stopIdEle] intValue];
		
		TBXMLElement *msgEle = [TBXML childElementNamed:@"msg" parentElement:busPredictionElement];
		error.msg = [TBXML textForElement:msgEle];
	} else {
		
		
		while(busPredictionElement != nil){
			BusPrediction *prediction = [[BusPrediction alloc] init];
			
			TBXMLElement *stpIdEle = [TBXML childElementNamed:@"stpid" parentElement:busPredictionElement];
			prediction.stopId = [TBXML textForElement:stpIdEle];
			
			TBXMLElement *tmstmp = [TBXML childElementNamed:@"tmstmp" parentElement:busPredictionElement];
			prediction.tmpStmp = [dateFormatter dateFromString: [TBXML textForElement:tmstmp]];
			
			//TBXMLElement *stopNameEle = [TBXML childElementNamed:@"stpnm" parentElement:busPredictionElement];
			//prediction.stopName = [TBXML textForElement:stopNameEle];
			
			//TBXMLElement *busNumberEle = [TBXML childElementNamed:@"vid" parentElement:busPredictionElement];
			//prediction.busNumber = [TBXML textForElement:busNumberEle];
			
			//TBXMLElement *routeDirEle = [TBXML childElementNamed:@"rtdir" parentElement:busPredictionElement];
			//prediction.routeDirection = [TBXML textForElement:routeDirEle];
			
			TBXMLElement *predictionEle = [TBXML childElementNamed:@"prdtm" parentElement:busPredictionElement];
			prediction.predictedTime = [dateFormatter dateFromString: [TBXML textForElement:predictionEle]];
			
			TBXMLElement *distToStopEle = [TBXML childElementNamed:@"dstp" parentElement:busPredictionElement];
			prediction.distToStop = [[TBXML textForElement:distToStopEle] integerValue];
			
			NSTimeInterval interval = [prediction.predictedTime timeIntervalSinceDate:prediction.tmpStmp];
			prediction.timeToStop = floor(interval/60);
			[mutableDirections addObject:prediction];
			[prediction release];
			
			busPredictionElement = [TBXML nextSiblingNamed:@"prd" searchFromElement:busPredictionElement];
		}
	}
	self.busData=nil;
	NSArray *array = [[NSArray alloc] initWithArray:mutableDirections];
	[mutableDirections release];
	
	return array; 
	
}

-(void) dealloc {
	[self.urlConnection release];
	[self.busData release];
	[super dealloc];
}
@end
