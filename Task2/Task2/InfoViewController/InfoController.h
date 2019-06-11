//
//  InfoController.h
//  Task2
//
//  Created by Roma on 6/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKContactsViewController.h"
#import "ContactsSource.h"
#import "ContactsData.h"
#import "ContactCell.h"
#import "InfoCell.h"
#import "PhoneCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoController : UITableViewController
- (instancetype)initWithContact:(CNContact*)contact;
@end

NS_ASSUME_NONNULL_END
