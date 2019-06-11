//
//  ContactsSource.m
//  Task2
//
//  Created by Roma on 6/10/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "ContactsSource.h"

@interface ContactsSource ()

@property (nonatomic, strong) NSMutableArray<ContactsData*> *allContacts;
@property (nonatomic, strong) CNContactStore *store;
@property (nonatomic, strong) NSMutableDictionary *tempContacts;


@end


@implementation ContactsSource

-(instancetype)init {
    self = [super init];
    if (self) {
        _allContacts = [NSMutableArray array];
    }
    return self;
}

-(void)beginFetchingData {
    
    __weak typeof(self) weakSelf = self;

    self.store = [[CNContactStore alloc] init];
    [self.store requestAccessForEntityType:(CNEntityTypeContacts) completionHandler:^(BOOL granted, NSError * _Nullable error) {

        if (granted) {
            [weakSelf fetchData];
        } else {
            if ([weakSelf.delegate respondsToSelector:@selector(accesDenied)]) {
                [weakSelf.delegate accesDenied];
            }
        }
    }];
}

-(void) fetchData
{
    self.tempContacts = [NSMutableDictionary dictionary];
    
    NSString *RuAlphabet = @"абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
    NSString *ENAlphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    CNContactFetchRequest* request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactImageDataAvailableKey]];
    
    self.store = [[CNContactStore alloc] init];
    
    [self.store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        if (![self checkingContact:contact inAlphabet:RuAlphabet] &&
            ![self checkingContact:contact inAlphabet:ENAlphabet]) {
            
            if ([self.tempContacts.allKeys containsObject:@"#"]) {
                [(NSMutableArray*)[self.tempContacts objectForKey:@"#"] addObject:contact];
            } else {
                [self.tempContacts setObject:[NSMutableArray arrayWithObject:contact] forKey:@"#"];
            }
        }
    }];
    
    
    for (NSUInteger i = 0; i < RuAlphabet.length; i++) {
        NSString *key = [RuAlphabet substringWithRange:(NSMakeRange(i, 1))];
        if ([self.tempContacts objectForKey:key]) {
            ContactsData* data = [[ContactsData alloc] init];
            data.isOpen = YES;
            data.sectionName = key;
            data.contacts = [self.tempContacts objectForKey:key];
            [self.allContacts addObject:data];
        }
    }
   
    for (NSUInteger i = 0; i < ENAlphabet.length; i++) {
        NSString *key = [ENAlphabet substringWithRange:(NSMakeRange(i, 1))];
        if ([self.tempContacts objectForKey:key]) {
            ContactsData* data = [[ContactsData alloc] init];
            data.isOpen = YES;
            data.sectionName = key;
            data.contacts = [self.tempContacts objectForKey:key];
            [self.allContacts addObject:data];
        }
    }
    
    if ([self.tempContacts objectForKey:@"#"]) {
        ContactsData* data = [[ContactsData alloc] init];
        data.isOpen = YES;
        data.sectionName = @"#";
        data.contacts = [self.tempContacts objectForKey:@"#"];
        [self.allContacts addObject:data];
    }
    
    [self.delegate contactsFetched:self.allContacts];
}

-(BOOL) checkingContact:(CNContact*) contact inAlphabet:(NSString*) alphabet{
    
    BOOL result = NO;
    
    for (NSUInteger i = 0; i < alphabet.length; i++) {
        NSString *key = [alphabet substringWithRange:(NSMakeRange(i, 1))];
        NSString *name = contact.givenName.lowercaseString;
        NSString *surname = contact.familyName.lowercaseString;

        if ((surname.length == 0 && [name hasPrefix:key]) || ([surname hasPrefix:key])) {
            if ([self.tempContacts.allKeys containsObject:key]) {
                [(NSMutableArray*)[self.tempContacts objectForKey:key] addObject:contact];
            } else {
                [self.tempContacts setObject:[NSMutableArray arrayWithObject:contact] forKey:key];
            }
            result = YES;
            break;
        }
    }
    return result;
}

@end
