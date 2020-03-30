//
//  AppDelegate.h
//  INGMovie
//
//  Created by Bahriye Begüm on 30.03.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

