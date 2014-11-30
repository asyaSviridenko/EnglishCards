//
//  EditListViewController.h
//  EnglishCards
//
//  Created by Anastasia Kononova on 10/23/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagedObjectContextHelper;
@class List;
@protocol EditListViewControllerDelegate;

@interface EditListViewController : UITableViewController

@property (nonatomic, weak) id<EditListViewControllerDelegate> delegate;

- (instancetype)initWithContextHelper:(ManagedObjectContextHelper *)contextHelper list:(List *)list NS_DESIGNATED_INITIALIZER;

@end

@protocol EditListViewControllerDelegate <NSObject>
- (void)editListViewController:(EditListViewController *)controller didUpdateList:(List *)list;
@end
