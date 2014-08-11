//
//  ManagedObjectContextHelper.h
//  EnglishCards
//
//  Created by asya on 04/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagedObjectContextHelper : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (ManagedObjectContextHelper *)sharedHelper;

- (instancetype)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL;

- (void)saveContext;

- (void)insertListWithName:(NSString *)name image:(UIImage *)image cards:(NSArray *)cards;
- (void)deleteListWithName:(NSString *)name;

- (void)insertCardWithFrontSide:(NSString *)front backSides:(NSArray *)backSides;
- (void)deleteCardWithFrontSide:(NSString *)front;

@end
