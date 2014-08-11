//
//  Card.h
//  EnglishCards
//
//  Created by Asya Kononova on 11/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardFrontSide, List;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * front;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) List *list;
@property (nonatomic, retain) NSOrderedSet *backSides;
@end

@interface Card (CoreDataGeneratedAccessors)

- (void)insertObject:(CardFrontSide *)value inBackSidesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBackSidesAtIndex:(NSUInteger)idx;
- (void)insertBackSides:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBackSidesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBackSidesAtIndex:(NSUInteger)idx withObject:(CardFrontSide *)value;
- (void)replaceBackSidesAtIndexes:(NSIndexSet *)indexes withBackSides:(NSArray *)values;
- (void)addBackSidesObject:(CardFrontSide *)value;
- (void)removeBackSidesObject:(CardFrontSide *)value;
- (void)addBackSides:(NSOrderedSet *)values;
- (void)removeBackSides:(NSOrderedSet *)values;
@end
