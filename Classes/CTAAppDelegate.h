//
//  CTAAppDelegate.h
//  CTA
//
//  Created by Vj on 3/24/11.
//  Copyright nistantrii.com 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define UIAppDelegate ((CTAAppDelegate *)[UIApplication sharedApplication].delegate)

@class Master;

@interface CTAAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UITabBarController *rootController;

@private
    Master *master;
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}
@property (nonatomic,retain) Master *master;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain) IBOutlet UITabBarController *rootController;

-(void) showError:(NSError *)error;
- (NSString *)applicationDocumentsDirectory;

@end

