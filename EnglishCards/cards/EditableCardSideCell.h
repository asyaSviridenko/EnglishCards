//
//  EditableCardSideCell.h
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditableCardSideCellDelegate;

@interface EditableCardSideCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, weak) id<EditableCardSideCellDelegate> delegate;

@end

@protocol EditableCardSideCellDelegate <NSObject>
- (void)editableCardSideCell:(EditableCardSideCell *)cell didChangeSide:(NSString *)side;
@end
