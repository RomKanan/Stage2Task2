//
//  RKContactsViewController.m
//  Task2
//
//  Created by Roma on 6/9/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "RKContactsViewController.h"
#import "ContactsSource.h"
#import "ContactsData.h"
#import "ContactCell.h"
#import "HeaderView.h"



@interface RKContactsViewController () <ContactSourceDelegate>

@property (nonatomic, strong) NSMutableArray<ContactsData *> *dataSource;
@property (nonatomic, strong) ContactsSource* contactsSource;
@property (nonatomic, strong) NSString* cell;
@end

@implementation RKContactsViewController

- (void)viewDidLoad {
    
    self.navigationItem.title = @"Контакты";
    [self.navigationController navigationBar].barTintColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.contactsSource = [[ContactsSource alloc] init];
    self.contactsSource.delegate = self;
    [self.contactsSource beginFetchingData];
    
    self.cell = @"contactCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:self.cell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section < self.dataSource.count)
    {
        ContactsData * sectionItem = [self.dataSource objectAtIndex:section];
        if (sectionItem.isOpen) {
            return sectionItem.contacts.count;
        }
        return 0;
    }
    
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cell];

    ContactsData * data = [self.dataSource objectAtIndex:indexPath.section];
    cell.nameLable.text = [NSString stringWithFormat:@"%@ %@",data.contacts[indexPath.row].givenName, data.contacts[indexPath.row].familyName];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    ContactsData * sectionItem = [self.dataSource objectAtIndex:section];
    view.sectionNameLable.text = sectionItem.sectionName.uppercaseString;
    view.quantityLable.text = [NSString stringWithFormat:@"%ld", sectionItem.contacts.count];
    [view.arrowButton addTarget:self action:@selector(headerButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    view.arrowButton.tag = section;
    UIImage* upArrow = [UIImage imageNamed:@"arrow_up"];
    UIImage* downArrow = [UIImage imageNamed:@"arrow_down"];
    
    if (!sectionItem.isOpen) {
        UIColor* yellow = [UIColor colorWithRed:217.f/256 green:145.f/256 blue:0.f alpha: 1.f];
        view.sectionNameLable.textColor = yellow;
        view.contactsLable.textColor = yellow;
        view.quantityLable.textColor = yellow;
        [view.arrowButton setBackgroundImage:upArrow forState:UIControlStateNormal];
    } else {
        UIColor* lightGray = [UIColor colorWithRed:153.f/256 green:153.f/256 blue:153.f/256 alpha: 1.f];
        view.sectionNameLable.textColor = [UIColor blackColor];
       view.contactsLable.textColor = lightGray;
        view.quantityLable.textColor = lightGray;
        [view.arrowButton setBackgroundImage:downArrow forState:UIControlStateNormal];
    }
    return view;
}

- (void)headerButtonPushed:(UIButton*) button{
    NSLog(@"Button in section %ld pushed", button.tag );
    NSMutableArray<NSIndexPath*> *indexPaths = [NSMutableArray array];
    for ( NSUInteger i = 0; i < self.dataSource[button.tag].contacts.count; i++ ){
        NSIndexPath* index = [NSIndexPath indexPathForRow:i inSection:button.tag];
        [indexPaths addObject:index];
    }
    if (self.dataSource[button.tag].isOpen) {
        self.dataSource[button.tag].isOpen = !self.dataSource[button.tag].isOpen;
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        self.dataSource[button.tag].isOpen = !self.dataSource[button.tag].isOpen;
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationNone];

}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     [self.dataSource[indexPath.section].contacts removeObjectAtIndex:indexPath.row];
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     if (self.dataSource[indexPath.section].contacts.count == 0) {
         [self.dataSource removeObjectAtIndex:indexPath.section];
         [tableView deleteSections:([NSIndexSet indexSetWithIndex:indexPath.section]) withRowAnimation:UITableViewRowAnimationFade];
     }
     [tableView reloadData];
    }

 }



 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     UIColor *hower = [UIColor colorWithRed:254.f/256 green:246.f/256 blue:230.f/256 alpha: 1.f];
     [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor = hower;
    
     ContactsData * data = [self.dataSource objectAtIndex:indexPath.section];
     
     NSString *name  = [NSString stringWithFormat:@"%@ %@",data.contacts[indexPath.row].givenName, data.contacts[indexPath.row].familyName];
     
     NSString *number = data.contacts[indexPath.row].phoneNumbers.firstObject.value.stringValue;
     
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:name message:number preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* action =  [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
     [alert addAction:action];
     [self presentViewController:alert animated:YES completion:nil];
 }
 


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor = [UIColor whiteColor];

}

- (void)accesDenied {
}

- (void)contactsFetched:(NSMutableArray<ContactsData *> *)contacts {
    self.dataSource = contacts;
    [self.tableView reloadData];
}


@end
