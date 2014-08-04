//
//  Card.h
//  EnglishCards
//
//  Created by asya on 27/07/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * front;
@property (nonatomic, retain) NSString * back;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) NSManagedObject *list;

@end
