//
//  Card.h
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) NSString * front;
@property (nonatomic, retain) NSString * back;
@property (nonatomic, retain) List *list;

@end
