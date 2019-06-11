//
//  HeaderView.h
//  Task2
//
//  Created by Roma on 6/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLable;
@property (weak, nonatomic) IBOutlet UILabel *contactsLable;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *quantityLable;


@end

NS_ASSUME_NONNULL_END
