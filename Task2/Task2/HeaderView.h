//
//  HeaderView.h
//  Task2
//
//  Created by Roma on 6/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderView;

@protocol HeaderDelegate <NSObject>
- (void)headerButtonPushes;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLable;
@property (weak, nonatomic) IBOutlet UILabel *contactsLable;
@property (weak, nonatomic) IBOutlet UILabel *quantityLable;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;
@property (weak, nonatomic) id<HeaderDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
