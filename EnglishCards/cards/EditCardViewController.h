//
//  EditCardViewController.h
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagedObjectContextHelper;
@class Card;
@protocol EditCardViewControllerDelegate;

@interface EditCardViewController : UITableViewController

@property (nonatomic, weak) id<EditCardViewControllerDelegate> delegate;

- (instancetype)initWithContextHelper:(ManagedObjectContextHelper *)contextHelper card:(Card *)card NS_DESIGNATED_INITIALIZER;

@end

@protocol EditCardViewControllerDelegate <NSObject>
- (void)editCardViewController:(EditCardViewController *)controller didUpdateCard:(Card *)card;
@end
