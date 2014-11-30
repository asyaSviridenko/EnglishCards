//
//  ListsViewController.m
//  EnglishCards
//
//  Created by asya on 27/07/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "ListsViewController.h"
#import "ManagedObjectContextHelper.h"
#import "EditListViewController.h"
#import "List.h"

@interface ListsViewController ()<EditListViewControllerDelegate>
@end

@implementation ListsViewController {
    ManagedObjectContextHelper *_contextHelper;
    NSArray *_lists;
    BOOL _isEditingMode;
}

- (instancetype)initWithManagedObjectContext:(ManagedObjectContextHelper *)contextHelper
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _contextHelper = contextHelper;
        _lists = [_contextHelper uploadAllLists];
        
        _isEditingMode = NO;
    }
    return self;
}

#pragma mark - UIView Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"My Lists";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(onEditButtonTap)];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Internals

- (BOOL)isAddListCellAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row >= _lists.count;
}

#pragma mark - Actions

- (void)onEditButtonTap
{
    _isEditingMode = !_isEditingMode;
    [self.tableView setEditing:_isEditingMode animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCellID"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listCellID"];
    }
    
    if ([self isAddListCellAtIndexPath:indexPath]) {
        cell.textLabel.text = @"Add new list...";
        cell.imageView.image = nil;
    } else {
        List *list = (List *)[_lists objectAtIndex:indexPath.row];
        cell.textLabel.text = list.name;
        cell.imageView.image = [UIImage imageWithData:list.image];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isEditingMode && ![self isAddListCellAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isEditingMode && ![self isAddListCellAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_contextHelper deleteList:[_lists objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    List *list = [self isAddListCellAtIndexPath:indexPath] ? [_contextHelper insertNewList] : [_lists objectAtIndex:indexPath.row];
    EditListViewController *controller = [[EditListViewController alloc] initWithContextHelper:_contextHelper list:list];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - EditListViewControllerDelegate

- (void)editListViewController:(EditListViewController *)controller didUpdateList:(List *)list
{
    _lists = [_contextHelper uploadAllLists];
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
