//
//  EditableListTitleCell.m
//  EnglishCards
//
//  Created by Anastasia Kononova on 10/23/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "EditableListTitleCell.h"

@interface EditableListTitleCell ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *titleTextField;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@end

@implementation EditableListTitleCell {
    UIImage *_defaultIcon;
}

- (void)awakeFromNib
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onIconTap)];
    [_iconImageView addGestureRecognizer:recognizer];
    
    _defaultIcon = [UIImage imageNamed:@"default_icon"];
}

- (void)onIconTap
{
    [_delegate editableTitleCellDidTapOnIconImage:self];
}

#pragma mark - Properties

- (NSString *)title
{
    return _titleTextField.text;
}

- (void)setTitle:(NSString *)title
{
    _titleTextField.text = title;
}

- (void)setIcon:(UIImage *)icon
{
    if (![_icon isEqual:icon]) {
        _icon = icon;
        _iconImageView.image = _icon != nil ? _icon : _defaultIcon;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_delegate editableTitleCell:self didEnterTitle:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
