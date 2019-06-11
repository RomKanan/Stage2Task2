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
        return sectionItem.contacts.count;
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
    return view;
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
/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)accesDenied {
}

- (void)contactsFetched:(NSMutableArray<ContactsData *> *)contacts {
    self.dataSource = contacts;
    [self.tableView reloadData];
}


@end
