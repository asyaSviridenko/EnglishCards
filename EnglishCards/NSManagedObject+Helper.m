//
//  NSManagedObject+Helper.m
//  EnglishCards
//
//  Created by asya on 04/08/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "NSManagedObject+Helper.h"

@implementation NSManagedObject (Helper)

+ (NSString*)entityName
{
    return NSStringFromClass(self.class);
}

@end
