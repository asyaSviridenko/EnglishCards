//
//  EditListViewController.m
//  EnglishCards
//
//  Created by Anastasia Kononova on 10/23/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "EditListViewController.h"
#import "ManagedObjectContextHelper.h"
#import "List.h"
#import "Card.h"
#import "EditableListTitleCell.h"
#import "EditCardViewController.h"
#import "UIImage+Icon.h"

typedef NS_ENUM(NSUInteger, EditListTableSections) {
    EditListTitleSection,
    EditListCardsSection
};

@interface EditListViewController ()<EditableListTitleCellDelegate, EditCardViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@implementation EditListViewController {
    ManagedObjectContextHelper *_contextHelper;
    List *_list;
    NSInteger _selectedCardIndex;
}

- (instancetype)initWithContextHelper:(ManagedObjectContextHelper *)contextHelper list:(List *)list
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _contextHelper = contextHelper;
        _list = list;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(onSaveTap)];
    [self updateSaveBarButtonEnabledState];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EditableListTitleCell" bundle:nil] forCellReuseIdentifier:@"editableTitleCellID"];
}

#pragma mark - Internals

- (BOOL)isAddCardCellAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row >= _list.cards.count;
}

- (void)updateSaveBarButtonEnabledState
{
    self.navigationItem.rightBarButtonItem.enabled = _list.name.length > 0;
}

#pragma mark - Actions

- (void)onSaveTap
{
    [_contextHelper saveContext];
    [_delegate editListViewController:self didUpdateList:_list];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == EditListTitleSection ? 1 : _list.cards.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case EditListTitleSection: {
            EditableListTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editableTitleCellID"];
            cell.delegate = self;
            cell.title = _list.name;
            cell.icon = [UIImage imageWithData:_list.image];
            
            return cell;
        }
        case EditListCardsSection: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardCellID"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cardCellID"];
            }
            
            cell.textLabel.text = [self isAddCardCellAtIndexPath:indexPath] ? @"Add new card..." : ((Card *)[_list.cards objectAtIndex:indexPath.row]).front;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == EditListCardsSection;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_contextHelper deleteCard:[_list.cards objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == EditListTitleSection ? @"Title" : @"Cards";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != EditListCardsSection) return;
    
    _selectedCardIndex = [self isAddCardCellAtIndexPath:indexPath] ? _list.cards.count : indexPath.row;
    
    Card *card = [self isAddCardCellAtIndexPath:indexPath] ? [_contextHelper insertNewCard] : [_list.cards objectAtIndex:indexPath.row];
    EditCardViewController *controller = [[EditCardViewController alloc] initWithContextHelper:_contextHelper card:card];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - EditableListTitleCellDelegate

- (void)editableTitleCell:(EditableListTitleCell *)cell didEnterTitle:(NSString *)title
{
    _list.name = title;
    [self updateSaveBarButtonEnabledState];
}

- (void)editableTitleCellDidTapOnIconImage:(EditableListTitleCell *)cell
{
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - EditCardViewControllerDelegate

- (void)editCardViewController:(EditCardViewController *)controller didUpdateCard:(Card *)card
{
    [_contextHelper addCard:card toList:_list];
    
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *icon = [info objectForKey:UIImagePickerControllerEditedImage];
    _list.image = [[icon roundedIcon] iconData];
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:EditListTitleSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
