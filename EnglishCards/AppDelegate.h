//
//  AppDelegate.h
//  EnglishCards
//
//  Created by asya on 27/07/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagedObjectContextHelper;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, readonly) ManagedObjectContextHelper *contextHelper;

+ (AppDelegate*)shared;

@end
