//
//  EditableListTitleCell.h
//  EnglishCards
//
//  Created by Anastasia Kononova on 10/23/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditableListTitleCellDelegate;

@interface EditableListTitleCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, weak) id<EditableListTitleCellDelegate> delegate;

@end

@protocol EditableListTitleCellDelegate <NSObject>
- (void)editableTitleCell:(EditableListTitleCell *)cell didEnterTitle:(NSString *)title;
- (void)editableTitleCellDidTapOnIconImage:(EditableListTitleCell *)cell;
@end
