//
//  AppDelegate.m
//  EnglishCards
//
//  Created by asya on 27/07/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "AppDelegate.h"
#import "ManagedObjectContextHelper.h"
#import "ListsViewController.h"

@implementation AppDelegate {
    UIWindow *_window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EnglishCards" withExtension:@"momd"];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EnglishCards.sqlite"];
    _contextHelper = [[ManagedObjectContextHelper alloc] initWithModelURL:modelURL storeURL:storeURL];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    _window.rootViewController = [[ListsViewController alloc] init];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.contextHelper saveContext];
}

+ (AppDelegate*)shared
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
