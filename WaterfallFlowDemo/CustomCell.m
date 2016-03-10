//
//  CustomCell.m
//  WaterfallFlowDemo
//
//  Created by Daniel on 16/3/10.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CustomCell *)cellWithTableView:(UITableView *)tableView {
    tableView.separatorStyle = 0;
    tableView.separatorColor = [UIColor clearColor];
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = 0;
    }
    return cell;
}

@end
