//
//  EditableCardSideCell.m
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "EditableCardSideCell.h"

@interface EditableCardSideCell ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation EditableCardSideCell

- (NSString *)title
{
    return _textField.text;
}

- (void)setTitle:(NSString *)title
{
    _textField.text = title;
}

- (NSString *)placeholder
{
    return _textField.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _textField.placeholder = placeholder;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_delegate editableCardSideCell:self didChangeSide:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
