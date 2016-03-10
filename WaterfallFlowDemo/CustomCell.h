//
//  CustomCell.h
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/10.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


+ (CustomCell *)cellWithTableView:(UITableView *)tableView;

@end
