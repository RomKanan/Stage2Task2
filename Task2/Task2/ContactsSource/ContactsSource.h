//
//  ContactsSource.h
//  Task2
//
//  Created by Roma on 6/10/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactsData.h"


NS_ASSUME_NONNULL_BEGIN
@class ContactsSource;

@protocol ContactSourceDelegate <NSObject>

- (void)contactsFetched:(NSMutableArray<ContactsData*>*) contacts;
- (void) accesDenied;

@end

@interface ContactsSource : NSObject

@property (nonatomic, weak) id<ContactSourceDelegate> delegate;

-(void)beginFetchingData;

@end

NS_ASSUME_NONNULL_END
