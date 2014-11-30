//
//  ManagedObjectContextHelper.h
//  EnglishCards
//
//  Created by asya on 04/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class List;
@class Card;

@interface ManagedObjectContextHelper : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (ManagedObjectContextHelper *)sharedHelper;

- (instancetype)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL;

- (void)saveContext;

- (NSArray *)uploadAllLists;

- (List *)insertNewList;
- (Card *)insertNewCard;

- (void)deleteList:(List *)list;
- (void)deleteCard:(Card *)card;

- (void)addCard:(Card *)card toList:(List *)list;

@end
