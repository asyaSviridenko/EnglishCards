//
//  ManagedObjectContextHelper.m
//  EnglishCards
//
//  Created by asya on 04/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "ManagedObjectContextHelper.h"
#import "AppDelegate.h"
#import "NSManagedObject+Helper.h"
#import "List.h"
#import "Card.h"

@implementation ManagedObjectContextHelper

+ (ManagedObjectContextHelper *)sharedHelper
{
    return [AppDelegate shared].contextHelper;
}

- (instancetype)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL
{
    self = [super init];
    if (self) {
        _managedObjectContext = [self managedObjectContextWithModelURL:modelURL storeURL:storeURL];
    }
    return self;
}

#pragma mark - Public

- (void)saveContext
{
    NSError *error = nil;
    
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)insertListWithName:(NSString *)name image:(UIImage *)image cards:(NSArray *)cards
{
    List *list = [self managedObjectWithEntityName:[List entityName]];
    list.name = name;
    list.image = UIImageJPEGRepresentation(image, 1.0f);
    [list addCards:[[NSOrderedSet alloc] initWithArray:cards]];
    
    [self saveContext];
}

- (void)deleteListWithName:(NSString *)name
{
    
}

- (void)insertCardWithFrontSide:(NSString *)front backSide:(NSString *)back
{
    
}

- (void)deleteCardWithFrontSide:(NSString *)front backSide:(NSString *)back
{
    
}

#pragma mark - Internals

- (NSManagedObjectContext *)managedObjectContextWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL
{
    if (_managedObjectContext != nil) {
        return  _managedObjectContext;
    }
    
    NSError *error = nil;
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    
    if (persistentStoreCoordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

- (id)managedObjectWithEntityName:(NSString*)name
{
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
}

@end
