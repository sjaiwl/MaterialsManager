//
//  AppDelegate.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/1/17.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//instance
+ (instancetype)getInstance;

- (BOOL)currentWindowWidthIsCompactWidth;

@end

