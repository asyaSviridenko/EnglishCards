//
//  ListsViewController.m
//  EnglishCards
//
//  Created by asya on 27/07/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "ListsViewController.h"
#import "ManagedObjectContextHelper.h"
#import "List.h"

@interface ListsViewController ()

@end

@implementation ListsViewController {
    ManagedObjectContextHelper *_contextHelper;
    NSArray *_lists;
    BOOL _isEditingMode;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _contextHelper = [ManagedObjectContextHelper sharedHelper];
        _lists = [_contextHelper uploadAllLists];
        _isEditingMode = NO;
    }
    return self;
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
}

#pragma mark - Internals


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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCellID" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listCellID"];
    }
    
    cell.textLabel.text = indexPath.row <_lists.count ? ((List *)[_lists objectAtIndex:indexPath.row]).name : @"Add new list...";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isEditingMode;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isEditingMode;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.navigationController pushViewController:detailViewController animated:YES];
}


@end
