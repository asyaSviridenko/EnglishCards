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

NSString * const ManagedObjectContextHelperDidChangeLists = @"ManagedObjectContextHelperDidChangeLists";

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

- (NSArray *)uploadAllLists
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:[List entityName] inManagedObjectContext:_managedObjectContext]];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]]];
    
    return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (List *)insertNewList
{
    List *list = [self managedObjectWithEntityName:[List entityName]];
    [self notifyListsChanged];
    
    return list;
}

- (Card *)insertNewCard
{
    return [self managedObjectWithEntityName:[Card entityName]];
}

- (void)deleteList:(List *)list
{
    [_managedObjectContext deleteObject:list];
    [self saveContext];
    
    [self notifyListsChanged];
}

- (void)deleteCard:(Card *)card
{
    [_managedObjectContext deleteObject:card];
    [self saveContext];
}

- (void)addCard:(Card *)card toList:(List *)list
{
    card.list = list;
    [self saveContext];
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

- (void)notifyListsChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ManagedObjectContextHelperDidChangeLists object:self];
}

@end
