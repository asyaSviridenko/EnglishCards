//
//  EditCardViewController.m
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "EditCardViewController.h"
#import "ManagedObjectContextHelper.h"
#import "Card.h"
#import "EditableCardDoneStateCell.h"
#import "EditableCardSideCell.h"

typedef NS_ENUM(NSUInteger, EditListTableSections) {
    EditCardFrontSideSection,
    EditCardBackSideSection,
    EditCardDoneSideSection
};

@interface EditCardViewController ()<EditableCardSideCellDelegate>

@end

@implementation EditCardViewController {
    ManagedObjectContextHelper *_contextHelper;
    Card *_card;
}

- (instancetype)initWithContextHelper:(ManagedObjectContextHelper *)contextHelper card:(Card *)card
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _contextHelper = contextHelper;
        _card = card;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Card";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(onSaveTap)];
    [self updateSaveBarButtonEnabledState];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EditableCardSideCell" bundle:nil] forCellReuseIdentifier:@"cardSideCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditableCardDoneStateCell" bundle:nil] forCellReuseIdentifier:@"cardDoneCellID"];
}

#pragma mark - Internals

- (void)updateSaveBarButtonEnabledState
{
    self.navigationItem.rightBarButtonItem.enabled = _card.front.length > 0 && _card.back.length > 0;
}

#pragma mark - Actions

- (void)onSaveTap
{
    [_contextHelper saveContext];
    [_delegate editCardViewController:self didUpdateCard:_card];
}

- (void)onDoneSwitchTap:(UISwitch *)switcher
{
    _card.done = @(switcher.isOn);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case EditCardBackSideSection: {
            EditableCardSideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardSideCellID"];
            cell.delegate = self;
            cell.title = _card.back;
            cell.placeholder = @"Back";
            cell.tag = indexPath.section;
            
            return cell;
        }
        case EditCardFrontSideSection: {
            EditableCardSideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardSideCellID"];
            cell.delegate = self;
            cell.title = _card.front;
            cell.placeholder = @"Front";
            cell.tag = indexPath.section;
            
            return cell;
        }
        case EditCardDoneSideSection: {
            EditableCardDoneStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardDoneCellID"];
            cell.doneSwitch.on = _card.done.boolValue;
            [cell.doneSwitch addTarget:self action:@selector(onDoneSwitchTap:) forControlEvents:UIControlEventValueChanged];
            
            return cell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark - EditableCardSideCellDelegate

- (void)editableCardSideCell:(EditableCardSideCell *)cell didChangeSide:(NSString *)side
{
    switch (cell.tag) {
        case EditCardBackSideSection:
            _card.back = side;
            break;
        case EditCardFrontSideSection:
            _card.front = side;
            break;
    }
    
    [self updateSaveBarButtonEnabledState];
}

@end
