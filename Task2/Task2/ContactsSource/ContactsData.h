//
//  ContactsData.h
//  Task2
//
//  Created by Roma on 6/10/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsData : NSObject
@property (nonatomic, strong) NSString *sectionName;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic,strong) NSMutableArray<CNContact*> *contacts;

@end

NS_ASSUME_NONNULL_END
