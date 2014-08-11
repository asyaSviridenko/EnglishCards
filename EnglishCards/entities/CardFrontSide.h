//
//  CardFrontSide.h
//  EnglishCards
//
//  Created by Asya Kononova on 11/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface CardFrontSide : NSManagedObject

@property (nonatomic, retain) NSString * back;
@property (nonatomic, retain) Card *card;

@end
