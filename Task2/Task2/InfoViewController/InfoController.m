//
//  InfoController.m
//  Task2
//
//  Created by Roma on 6/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "InfoController.h"
#import "RKContactsViewController.h"
#import "ContactsSource.h"
#import "ContactsData.h"
#import "ContactCell.h"
#import "InfoCell.h"
#import "PhoneCell.h"


@interface InfoController ()
@property (strong, nonatomic) CNContact* contact;
@end

@implementation InfoController

- (instancetype)initWithContact:(CNContact*)contact {
    self = [super init];
    if (self) {
        _contact = contact;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Контакты";
    
    UIImage *backArrow = [UIImage imageNamed:@"arrow_left"];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:backArrow style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPushed:)];
    
    back.tintColor = UIColor.blackColor;
    self.navigationItem.leftBarButtonItem = back;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PhoneCell" bundle:nil] forCellReuseIdentifier:@"phoneCell"];
}

-(void)backButtonPushed:(id)send {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.contact.phoneNumbers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        cell.fullNameLable.text = [NSString stringWithFormat:@"%@ %@", self.contact.givenName, self.contact.familyName];
        cell.photoImageView.layer.cornerRadius = 75.f;
        if (self.contact.imageDataAvailable) {
            cell.photoImageView.image = [UIImage imageWithData:self.contact.imageData];
        } else {
            cell.photoImageView.image = [UIImage imageNamed:@"noPhoto"];
        }
        return cell;
    }
    
    PhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phoneCell" forIndexPath:indexPath];
    cell.phoneNumberLable.text = self.contact.phoneNumbers[indexPath.row - 1].value.stringValue;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 300.f;
    }
    return 70.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] init];
    return view;
}
@end
